@echo off
echo Starting BodSpas local server...
echo.
cd /d "%~dp0"
start "BodSpas Server" python -m http.server 8000
timeout /t 2 /nobreak >nul
start "" "http://localhost:8000"
echo Server running at http://localhost:8000
echo Close the "BodSpas Server" window to stop.
