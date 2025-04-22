# Install-APK.ps1

# Update paths with quotes
$apkPath = "`"$env:USERPROFILE\Desktop\platform-tools\yout-app-name.apk`""
$adbPath = "`"$env:USERPROFILE\Desktop\platform-tools\adb.exe`""

# Check if APK exists
if (-not (Test-Path $apkPath)) {
    Write-Host "ERROR: APK file not found at '$apkPath'!" -ForegroundColor Red
    exit 1
}

# Restart ADB server
& $adbPath kill-server | Out-Null
Start-Sleep -Milliseconds 500
& $adbPath start-server | Out-Null

# Connect to Android subsystem (WSA/emulator)
& $adbPath connect 127.0.0.1:58526 | Out-Null

# Check device connection
$devices = & $adbPath devices | Select-String -Pattern "device$"
if (-not $devices) {
    Write-Host "ERROR: No ADB devices found. Start WSA/emulator first!" -ForegroundColor Red
    exit 1
}

# Install APK
& $adbPath install -r "`"$apkPath`""

if ($LASTEXITCODE -eq 0) {
    Write-Host "Success: APK installed!" -ForegroundColor Green
} else {
    Write-Host "ERROR: Installation failed (code $LASTEXITCODE)." -ForegroundColor Red
}