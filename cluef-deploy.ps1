# Cluef-Deploy-Skript für Windows (PowerShell)
# Führe dieses Skript als Administrator aus!

# 1. Node.js und npm installieren
If (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Installiere Node.js und npm..."
    $nodeUrl = "https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi"
    $installerPath = "$env:TEMP\nodejs-installer.msi"
    
    # Installer herunterladen
    Invoke-WebRequest -Uri $nodeUrl -OutFile $installerPath
    
    # Silent-Installation
    Start-Process msiexec -ArgumentList "/i `"$installerPath`" /quiet" -Wait
    
    # PATH-Variable aktualisieren
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 2. Projektabhängigkeiten installieren
Write-Host "Installiere node-fetch und Netlify CLI..."
npm install node-fetch
npm install -g netlify-cli

# 3. Git konfigurieren (ersetze NAME und EMAIL)
Write-Host "Konfiguriere Git..."
git config --global user.name "Dein Name"
git config --global user.email "deine@email.com"

# 4. GitHub-Repository initialisieren und pushen
Write-Host "Initialisiere Git-Repository..."
git init
git add .
git commit -m "Erstes Deployment mit Auth0 und Netlify Functions"
git branch -M main
git remote add origin https://github.com/DEIN-BENUTZER/cluef-website.git
git push -u origin main

# 5. Netlify-Login und Deployment
Write-Host "Logge dich bei Netlify ein..."
netlify login
netlify deploy --prod
