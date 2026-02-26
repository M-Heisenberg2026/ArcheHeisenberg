@echo off
REM =============================================================================
REM ARCHEHEISENBERG USB - Windows Launcher
REM =============================================================================
REM Doppelklick zum Starten!
REM =============================================================================

echo.
echo  #########################################
echo  #     🧬 ARCHEHEISENBERG USB           #
echo  #     ⚡ One-Click Deployment           #
echo  #########################################
echo.

REM Check if running as admin (needed for Docker)
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ⚠️  Admin-Rechte empfohlen fuer Docker-Installation
    echo.
)

REM Check for WSL (better for Docker on Windows)
where wsl >nul 2>&1
if %errorLevel% equ 0 (
    echo ✅ WSL gefunden - Docker Desktop empfohlen
) else (
    echo ℹ️  Docker Desktop wird benoetigt
)

echo.
echo  Was moechtest du tun?
echo.
echo  [1] 🚀 START - Alles automatisch installieren
echo  [2] 🔍 System-Check
echo  [3] 🐳 Docker installieren
echo  [4] 🔑 API-Keys einrichten
echo  [5] 🌐 Bento Menu oeffnen
echo  [6] 📖 Dokumentation
echo  [Q] Beenden
echo.
set /p choice="Auswahl: "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto check
if "%choice%"=="3" goto docker
if "%choice%"=="4" goto keys
if "%choice%"=="5" goto bento
if "%choice%"=="6" goto docs
if "%choice%"=="q" goto end
if "%choice%"=="Q" goto end

:start
echo.
echo ⏳ Starte automatische Installation...
call ar cheheisenberg.sh
goto end

:check
echo.
echo 🔍 Pruefe System...
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
where docker >nul 2>&1 && echo ✅ Docker gefunden || echo ❌ Docker nicht gefunden
pause
goto end

:docker
echo.
echo 🐳 Oeffne Docker Download-Seite...
start https://www.docker.com/products/docker-desktop
goto end

:keys
echo.
echo 🔑 API-Key Einrichtung
echo.
echo Bitte folgende Keys bereithalten:
echo   - OpenAI API Key (sk-...)
echo   - Anthropic API Key (sk-ant-...)
echo   - MiniMax API Key
echo.
pause
goto end

:bento
echo.
echo 🌐 Oeffne Bento Menu...
start "" "%~dp0index.html"
goto end

:docs
echo.
echo 📖 Oeffne Dokumentation...
if exist "%~dp0README.md" (
    start notepad "%~dp0README.md"
) else (
    echo README.md nicht gefunden
    pause
)
goto end

:end
echo.
echo  ✅ Fertig!
timeout /t 2 >nul
