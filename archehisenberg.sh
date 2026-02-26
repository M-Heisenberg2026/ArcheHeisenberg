#!/bin/bash
# =============================================================================
# ARCHEHEISENBERG USB - One-Click Deployment
# =============================================================================
# Usage: ./archehisenberg.sh
#        (Doppelklick auf Windows/Mac, execute auf Linux)
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Config
REPO_URL="https://github.com/M-Heisenberg2026/OpenClaw_MHeisenberg.git"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPTS_DIR/archehisenberg.log"

# =============================================================================
# UTILITIES
# =============================================================================

log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_info() { log "${BLUE}ℹ️  $1${NC}"; }
log_ok() { log "${GREEN}✅  $1${NC}"; }
log_warn() { log "${YELLOW}⚠️  $1${NC}"; }
log_error() { log "${RED}❌  $1${NC}"; }

# =============================================================================
# OS DETECTION
# =============================================================================

detect_os() {
    log_info "Erkenne Betriebssystem..."
    
    case "$(uname -s)" in
        Linux*)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                OS="$ID"
                OS_NAME="$NAME"
            else
                OS="linux"
                OS_NAME="Linux"
            fi
            ;;
        Darwin*)
            OS="macos"
            OS_NAME="macOS"
            ;;
        CYGWIN*|MINGW*|MSYS*)
            OS="windows"
            OS_NAME="Windows"
            ;;
        *)
            OS="unknown"
            OS_NAME="Unknown"
            ;;
    esac
    
    log_ok "Betriebssystem erkannt: $OS_NAME ($OS)"
    echo "$OS"
}

# =============================================================================
# DOCKER CHECK & INSTALL
# =============================================================================

check_docker() {
    log_info "Prüfe Docker..."
    
    if command -v docker &> /dev/null; then
        if docker info &> /dev/null; then
            log_ok "Docker ist bereits installiert und läuft!"
            return 0
        else
            log_warn "Docker ist installiert, aber läuft nicht. Bitte Docker Desktop starten."
            return 1
        fi
    fi
    
    return 2
}

install_docker_linux() {
    log_info "Installiere Docker für Linux..."
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then
        log_warn "Docker-Installation erfordert Root-Rechte."
        log_warn "Bitte mit 'sudo $0' ausführen oder Docker manuell installieren."
        return 1
    fi
    
    # Install Docker
    apt-get update -y
    apt-get install -y docker.io
    
    # Start Docker
    systemctl start docker
    systemctl enable docker
    
    # Add current user to docker group
    usermod -aG docker "$SUDO_USER"
    
    log_ok "Docker installiert! Bitte neu anmelden oder 'newgrp docker' ausführen."
}

install_docker_macos() {
    log_warn "Docker Desktop muss manuell heruntergeladen werden:"
    log_warn "  https://www.docker.com/products/docker-desktop"
    log_warn ""
    log_warn "Nach der Installation: Docker Desktop starten und erneut dieses Script ausführen."
    return 1
}

install_docker_windows() {
    log_warn "Docker Desktop muss manuell heruntergeladen werden:"
    log_warn "  https://www.docker.com/products/docker-desktop"
    log_warn ""
    log_warn "Nach der Installation: Docker Desktop starten und erneut dieses Script ausführen."
    return 1
}

install_docker() {
    local os="$1"
    
    local status=$(check_docker)
    
    if [ $status -eq 0 ]; then
        return 0
    elif [ $status -eq 1 ]; then
        return 1
    fi
    
    # Docker not installed - install it
    case "$os" in
        linux)
            install_docker_linux
            ;;
        macos)
            install_docker_macos
            ;;
        windows)
            install_docker_windows
            ;;
        *)
            log_error "Unbekanntes OS: $os"
            return 1
            ;;
    esac
}

# =============================================================================
# DOWNLOAD SCRIPTS
# =============================================================================

download_scripts() {
    log_info "Lade Scripts herunter..."
    
    local target_dir="$SCRIPTS_DIR/openclaw"
    
    if [ -d "$target_dir" ]; then
        log_info "Update bestehende Installation..."
        cd "$target_dir"
        git pull origin main 2>/dev/null || true
    else
        log_info "Klone Repository..."
        git clone "$REPO_URL" "$target_dir"
        cd "$target_dir"
    fi
    
    log_ok "Scripts heruntergeladen nach: $target_dir"
    echo "$target_dir"
}

# =============================================================================
# API KEY SETUP
# =============================================================================

setup_api_keys() {
    log_info "API-Key Einrichtung..."
    echo ""
    echo "============================================"
    echo "  🔑 API-KEY EINRICHTUNG"
    echo "============================================"
    echo ""
    echo "Du brauchst folgende API-Keys:"
    echo "  1. OpenAI API Key (für STT/TTS)"
    echo "  2. Anthropic API Key (für Claude)"
    echo "  3. MiniMax API Key (für schnelle Inference)"
    echo ""
    echo "Drücke Enter um fortzufahren..."
    read
    
    # Check if keys exist in environment
    if [ -z "$OPENAI_API_KEY" ]; then
        echo -n "OpenAI API Key (sk-...): "
        read -s OPENAI_API_KEY
        echo ""
        export OPENAI_API_KEY
    fi
    
    if [ -z "$ANTHROPIC_API_KEY" ]; then
        echo -n "Anthropic API Key (sk-ant-...): "
        read -s ANTHROPIC_API_KEY
        echo ""
        export ANTHROPIC_API_KEY
    fi
    
    if [ -z "$MINIMAX_API_KEY" ]; then
        echo -n "MiniMax API Key: "
        read -s MINIMAX_API_KEY
        echo ""
        export MINIMAX_API_KEY
    fi
    
    log_ok "API-Keys gespeichert (Session-only)"
}

# =============================================================================
# START CONTAINER
# =============================================================================

start_container() {
    local scripts_dir="$1"
    
    log_info "Starte Heisenberg-Container..."
    
    # Check if Docker is running
    if ! docker info &> /dev/null; then
        log_error "Docker läuft nicht! Bitte Docker Desktop starten."
        return 1
    fi
    
    # Build and run OpenClaw
    cd "$scripts_dir"
    
    if [ -f "Dockerfile" ]; then
        log_info "Baue Container..."
        docker build -t heisenberg:latest .
    fi
    
    if [ -f "docker-compose.yml" ]; then
        log_info "Starte mit docker-compose..."
        docker-compose up -d
    else
        log_info "Starte Container manuell..."
        docker run -d \
            --name heisenberg \
            -p 18789:18789 \
            -v "$SCRIPTS_DIR:/workspace" \
            -e OPENAI_API_KEY \
            -e ANTHROPIC_API_KEY \
            -e MINIMAX_API_KEY \
            heisenberg:latest
    fi
    
    log_ok "🚀 Heisenberg ist gestartet!"
    echo ""
    echo "============================================"
    echo "  🎉 FERTIG!"
    echo "============================================"
    echo ""
    echo "  Heisenberg läuft auf: http://localhost:18789"
    echo ""
}

# =============================================================================
# MAIN
# =============================================================================

main() {
    echo ""
    echo "============================================"
    echo "  🧬 ARCHEHEISENBERG USB"
    echo "  ⚡ One-Click Heisenberg Deployment"
    echo "============================================"
    echo ""
    
    # Detect OS
    OS=$(detect_os)
    
    # Check/install Docker
    install_docker "$OS" || exit 1
    
    # Download scripts
    SCRIPTS_DIR=$(download_scripts)
    
    # Setup API keys
    setup_api_keys
    
    # Start container
    start_container "$SCRIPTS_DIR"
    
    log_ok "Alles erledigt! 🎉"
}

# Run
main "$@"
