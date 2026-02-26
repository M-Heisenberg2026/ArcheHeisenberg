#!/bin/bash
# =============================================================================
# ARCHEHEISENBERG USB - macOS App Launcher
# =============================================================================
# Usage: Doppelklick auf "ArcheHeisenberg.app" im Finder
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for Terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "  #########################################"
echo "  #     🧬 ARCHEHEISENBERG USB           #"
echo "  #     ⚡ One-Click Deployment (macOS)   #"
echo "  #########################################"
echo ""

# Menu
echo "  Was möchtest du tun?"
echo ""
echo "  [1] 🚀  START - Alles automatisch installieren"
echo "  [2] 🔍  System-Check"
echo "  [3] 🐳  Docker Desktop herunterladen"
echo "  [4] 🔑  API-Keys einrichten"
echo "  [5] 🌐  Bento Menu öffnen"
echo "  [6] 📖  Dokumentation"
echo "  [Q]  Beenden"
echo ""

read -p "Auswahl: " choice

case "$choice" in
    1)
        echo ""
        echo "⏳ Starte automatische Installation..."
        bash "$SCRIPT_DIR/archehisenberg.sh"
        ;;
    2)
        echo ""
        echo "🔍 Prüfe System..."
        sw_vers
        echo ""
        docker --version >/dev/null 2>&1 && echo "✅ Docker gefunden" || echo "❌ Docker nicht gefunden"
        echo ""
        read -p "Drücke Enter zum Fortfahren..."
        ;;
    3)
        echo ""
        echo "🐳 Öffne Docker Download-Seite..."
        open "https://www.docker.com/products/docker-desktop"
        ;;
    4)
        echo ""
        echo "🔑 API-Key Einrichtung"
        echo ""
        echo "Bitte folgende Keys bereithalten:"
        echo "  - OpenAI API Key (sk-...)"
        echo "  - Anthropic API Key (sk-ant-...)"
        echo "  - MiniMax API Key"
        echo ""
        read -p "Drücke Enter zum Fortfahren..."
        ;;
    5)
        echo ""
        echo "🌐 Öffne Bento Menu..."
        open "$SCRIPT_DIR/index.html"
        ;;
    6)
        echo ""
        echo "📖 Öffne Dokumentation..."
        if [ -f "$SCRIPT_DIR/README.md" ]; then
            open "$SCRIPT_DIR/README.md"
        else
            echo "README.md nicht gefunden"
        fi
        read -p "Drücke Enter zum Fortfahren..."
        ;;
    q|Q)
        echo ""
        echo "👋 Bis bald!"
        ;;
esac
