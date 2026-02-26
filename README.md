# 🧬 ArcheHeisenberg USB

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue?style=for-the-badge&logo=multi-factor-authentication" alt="Platform">
  <img src="https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker" alt="Docker">
  <img src="https://img.shields.io/badge/Heisenberg-AI-00FF88?style=for-the-badge&logo=artificial-intelligence" alt="Heisenberg AI">
</p>

---

## ⚡ Quick Start

### Windows
```
1. USB einstecken
2. launcher.bat doppelklicken
3. [1] START drücken
```

### macOS
```
1. USB einstecken
2. launcher.command doppelklicken
3. [1] START eingeben
```

### Linux
```
1. USB einstecken
2. sudo ./archehisenberg.sh
```

---

## 📦 Was ist ArcheHeisenberg?

**Dein One-Click AI-Assistent auf USB!**

```
┌─────────────────────────────────────────────────────────┐
│  🧬 ARCHEHEISENBERG USB                               │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  📄 ar cheheisenberg.sh (Doppelklick!)                │
│                                                         │
│  → Erkennt OS (Windows/Linux/Mac)                      │
│  → Installiert automatisch:                            │
│    • Windows: Docker Desktop + VMs                     │
│    • Linux: Docker + Container                          │
│    • Mac: Docker Desktop                               │
│  → Richtet alles ein                                   │
│  → Startet Heisenberg                                  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🖥️ System-Anforderungen

| Komponente | Windows | macOS | Linux |
|------------|---------|-------|-------|
| OS | 10/11 | 11+ | Ubuntu 20.04+ |
| RAM | 4 GB | 4 GB | 4 GB |
| Speicher | 10 GB | 10 GB | 10 GB |
| Docker | ✅ | ✅ | ✅ |

---

## 🔑 API-Keys (optional)

Du brauchst mindestens einen:

| Anbieter | Key-Typ | Website |
|----------|---------|---------|
| **OpenAI** | `sk-...` | [platform.openai.com](https://platform.openai.com) |
| **Anthropic** | `sk-ant-...` | [console.anthropic.com](https://console.anthropic.com) |
| **MiniMax** | `...` | [platform.minimaxi.com](https://platform.minimaxi.com) |

> 💡 **Tipp:** Startet auch ohne Keys, aber mit eingeschränkten Features.

---

## 🚀 Usage

### Option 1: Bento Menu (empfohlen)

```bash
# Öffnet schönes GUI im Browser
./bento-launcher.py
# oder: doppelklick auf index.html
```

### Option 2: CLI

```bash
# Vollautomatisch
sudo ./archehisenberg.sh

# Schritt-für-Schritt
./archehisenberg.sh --interactive
```

### Option 3: Menu

```bash
# Windows
launcher.bat

# macOS
./launcher.command

# Linux
./archehisenberg.sh --menu
```

---

## 🔧 Manual Setup

### 1. Docker installieren

**Windows:**
```powershell
# Download: https://www.docker.com/products/docker-desktop
# Installieren und starten
```

**macOS:**
```bash
# Download: https://www.docker.com/products/docker-desktop
# Installieren und starten
```

**Linux:**
```bash
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
# Neuanmeldung erforderlich!
```

### 2. Scripts herunterladen

```bash
git clone https://github.com/M-Heisenberg2026/OpenClaw_MHeisenberg.git
cd OpenClaw_MHeisenberg
```

### 3. Starten

```bash
# Vollautomatisch
sudo ./archehisenberg.sh

# Oder manuell
docker-compose up -d
```

---

## 🎯 Features

- ✅ **One-Click** - Alles automatisch
- ✅ **Cross-Platform** - Windows, macOS, Linux
- ✅ **Docker-basiert** - Sauber und isoliert
- ✅ **API-Keys** - OpenAI, Anthropic, MiniMax
- ✅ **Bento UI** - Modernes Web-Interface
- ✅ **USB-Ported** - Tragbar!

---

## 🐛 Troubleshooting

### "Docker nicht gefunden"
```bash
# Docker installieren (siehe oben)
# Oder: Docker Desktop starten
```

### "Permission denied"
```bash
# Linux: mit sudo starten
sudo ./archehisenberg.sh

# Oder ausführbar machen
chmod +x ar cheheisenberg.sh
```

### "API-Keys fehlen"
```bash
# Keys eingeben beim Start
# Oder als Environment Variable:
export OPENAI_API_KEY="sk-..."
./archehisenberg.sh
```

### "Port 18789 belegt"
```bash
# Port prüfen
lsof -i :18789

# Container stoppen
docker stop heisenberg
```

---

## 📁 Dateien

| Datei | Beschreibung |
|-------|--------------|
| `archehisenberg.sh` | Haupt-Script (Linux/macOS) |
| `launcher.bat` | Windows CLI-Menu |
| `launcher.command` | macOS CLI-Menu |
| `index.html` | Bento Web-UI |
| `autorun.inf` | Windows USB-Autostart |
| `bento-launcher.py` | Python Browser-Launcher |

---

## 🐳 Docker Hub (ohne Bauen)

**Fertiges Image ziehen und direkt starten:**

```bash
# Image ziehen
docker pull heisenberg/archehisenberg:latest

# Container starten
docker run -d \
  --name heisenberg \
  -p 18789:18789 \
  -e OPENAI_API_KEY="sk-..." \
  -e ANTHROPIC_API_KEY="sk-ant-..." \
  heisenberg/archehisenberg:latest

# Oder mit docker-compose
docker-compose up -d
```

**Image Links:**
- 🐳 Docker Hub: https://hub.docker.com/r/heisenberg/archehisenberg
- 📦 GitHub Container Registry: `ghcr.io/M-Heisenberg2026/archehisenberg`

---

## 🤝 Credits

- **Heisenberg** - Der AI-Assistent ⚛️
- **OpenClaw** - Das Framework
- **Docker** - Container-Technologie

---

## 📜 Lizenz

MIT License - Mach damit was du willst! 😈

---

<p align="center">
  <sub>Made with ⚛️ by Heisenberg</sub>
</p>
