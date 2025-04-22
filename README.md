# APK/XAPK Installer for Windows Subsystem for Android (WSA)

PowerShell scripts to install **APK/XAPK files** on Windows 11 via the Windows Subsystem for Android (WSA) or Android emulators like BlueStacks.

![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?logo=powershell&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?logo=android&logoColor=white)

---

## 📂 Directory Structure

XAPK-APK-Installer-Win11/

├── adb.exe # Android Debug Bridge

├── Install-apk.ps1 # Script to install standard APKs

├── Install-xapk.ps1 # Script to install XAPK bundles

├── run.ps1 # Helper script (optional)

├── app-name.xapk # Example XAPK file (replace with yours)

└── (Other ADB tools: fastboot.exe, etc.)

---

## 🛠️ Prerequisites
1. **Windows 11** with [WSA](https://learn.microsoft.com/en-us/windows/android/wsa/) **OR** an Android emulator (BlueStacks/NoxPlayer).
2. **[Android Platform Tools](https://developer.android.com/studio/releases/platform-tools)** (`adb.exe` included in your folder).
3. **[aapt.exe](https://github.com/rendiix/aapt-static)** (Download and place in `XAPK-APK-Installer-Win11` for XAPK support).
4. Enable **Developer Mode** in WSA/emulator settings.

---

## 🚀 Features

- Installs standard APK files (`Install-apk.ps1`).
- Handles split APK/XAPK bundles (`Install-xapk.ps1`).
- Automates OBB file deployment for games/apps.
- Supports WSA (port `58526`) and emulators (e.g., BlueStacks port `5555`).

---

## 📋 Usage

### For APK Files
1. Place your `.apk` file in the `XAPK-APK-Installer-Win11` folder (e.g., `app-name.apk`).
2. Run in PowerShell:
   
   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force
   .\Install-apk.ps1
   ```

### For XAPK Files
Place your .xapk file in the XAPK-APK-Installer-Win11 folder (e.g., app-name.xapk).

Ensure aapt.exe is in the XAPK-APK-Installer-Win11 folder.

Run:
   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force
   .\Install-xapk.ps1
   ```

## 🔧 Troubleshooting
Error	Solution
No APK files found	- Verify the XAPK file is valid (test with 7-Zip)

- Ensure aapt.exe is present
  
adb.exe: no devices found	- Start WSA/emulator first

- Check ADB port in script

INSTALL_FAILED_MISSING_SPLIT	Use Install-xapk.ps1 instead of Install-apk.ps1

Permission Denied	Run PowerShell as Administrator

## ⚙️ Script Configuration
Edit these variables in the scripts if needed:

# In Install-apk.ps1/Install-xapk.ps1
   ```
   $apkPath = "$env:USERPROFILE\Desktop\XAPK-APK-Installer-Win11\app-name.apk"
   $xapkPath = "$env:USERPROFILE\Desktop\XAPK-APK-Installer-Win11\app-name.xapk"
   $adbPath = "$env:USERPROFILE\Desktop\XAPK-APK-Installer-Win11\adb.exe"
   $adbPort = "127.0.0.1:58526"  # WSA default port
   ```

## 📝 Notes
WSA Setup: Enable Developer Mode in Windows Subsystem for Android settings.

Emulator Ports:

BlueStacks: 127.0.0.1:5555

NoxPlayer: 127.0.0.1:62001

For ARM apps on x86 systems, use **WSA PacMan**.


## 📜 License

MIT License. See LICENSE for details.
