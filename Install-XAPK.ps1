# Install-xapk.ps1

# Paths
$xapkPath = "$env:USERPROFILE\Desktop\platform-tools\google.xapk"
$adbPath = "$env:USERPROFILE\Desktop\platform-tools\adb.exe"
$tempDir = "$env:TEMP\Cursa_Extracted"
$tempZip = "$env:TEMP\GooglePlay.zip"

# Cleanup
Remove-Item $tempDir, $tempZip -Recurse -Force -ErrorAction SilentlyContinue
mkdir $tempDir -Force

# Convert .xapk to .zip and extract
Copy-Item $xapkPath -Destination $tempZip
Expand-Archive -Path $tempZip -DestinationPath $tempDir -Force

# Debug: List extracted files
Write-Host "Extracted files:`n$(Get-ChildItem $tempDir -Recurse | Format-Table -AutoSize | Out-String)"

# Find ALL APKs (remove restrictive filters)
$apkFiles = Get-ChildItem $tempDir -Filter *.apk -Recurse
if (-not $apkFiles) {
    Write-Host "ERROR: No APKs found. Check if .xapk is valid or extract manually." -ForegroundColor Red
    exit 1
}

# ADB Setup
& $adbPath kill-server
Start-Sleep -Milliseconds 500
& $adbPath start-server
& $adbPath connect 127.0.0.1:58526

# Install APKs (use full paths)
$apkPaths = $apkFiles.FullName
& $adbPath install-multiple $apkPaths

# Push OBB files (if they exist)
$obbDir = Get-ChildItem $tempDir -Directory -Filter "obb" -Recurse
if ($obbDir) {
    # Extract package name from first APK
    $manifest = & $adbPath shell "aapt dump badging $($apkFiles[0].FullName)"
    $packageName = ($manifest | Select-String "package: name='([^']+)").Matches.Groups[1].Value
    $obbDest = "/sdcard/Android/obb/$packageName/"
    
    & $adbPath shell "mkdir -p $obbDest"
    & $adbPath push "$($obbDir.FullName)\*" $obbDest
}

# Cleanup
Remove-Item $tempDir, $tempZip -Recurse -Force
Write-Host "Installation completed. Check your Android subsystem for the app!"