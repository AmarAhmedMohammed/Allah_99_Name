# Download All Audio Files - Complete Instructions

## 📥 Download Process

### Step-by-Step Guide

#### 1️⃣ Choose Your Method

**Method A: Automatic (Recommended)**
- Windows: Double-click `download_audio.bat`
- Mac/Linux: Run `./download_audio.sh`
- Any OS: Run `python3 download_audio.py`

**Method B: Manual**
- Download each file individually from the URLs below

---

## 🤖 Automatic Download (Recommended)

### Windows Users:

1. Open File Explorer
2. Navigate to your project folder
3. Find `download_audio.bat`
4. **Double-click** the file
5. A command window will open
6. Wait for "Download process completed!"
7. Press any key to close

**Expected Output:**
```
============================================================
Downloading Beautiful Recitations of Allah's 99 Names
============================================================

Installing required packages...
Starting download...

[1/99] Downloading 001.mp3...
  Source: Islamic Finder
  ✓ Downloaded (245,678 bytes)

[2/99] Downloading 002.mp3...
  ✓ Downloaded (198,432 bytes)

... (continues for all 99 files)

============================================================
DOWNLOAD SUMMARY
============================================================
✓ Successful: 99/99
✗ Failed: 0/99

🎉 All audio files downloaded successfully!
📁 Location: D:\Allah_99_Name\allah_name\assets\audio

============================================================
Download process completed!
============================================================
Press any key to continue...
```

### Mac/Linux Users:

1. Open Terminal
2. Navigate to your project:
   ```bash
   cd /path/to/your/project
   ```
3. Make script executable:
   ```bash
   chmod +x download_audio.sh
   ```
4. Run the script:
   ```bash
   ./download_audio.sh
   ```
5. Wait for completion

---

## 📋 Manual Download URLs

If automatic download doesn't work, download these files manually:

### All 99 Audio Files:

Save each file as `001.mp3`, `002.mp3`, etc. in `assets/audio/` folder:

```
1.  https://www.islamicfinder.us/audios/asma-ul-husna/001.mp3  (Ar-Rahman)
2.  https://www.islamicfinder.us/audios/asma-ul-husna/002.mp3  (Ar-Rahim)
3.  https://www.islamicfinder.us/audios/asma-ul-husna/003.mp3  (Al-Malik)
4.  https://www.islamicfinder.us/audios/asma-ul-husna/004.mp3  (Al-Quddus)
5.  https://www.islamicfinder.us/audios/asma-ul-husna/005.mp3  (As-Salam)
6.  https://www.islamicfinder.us/audios/asma-ul-husna/006.mp3  (Al-Mu'min)
7.  https://www.islamicfinder.us/audios/asma-ul-husna/007.mp3  (Al-Muhaymin)
8.  https://www.islamicfinder.us/audios/asma-ul-husna/008.mp3  (Al-Aziz)
9.  https://www.islamicfinder.us/audios/asma-ul-husna/009.mp3  (Al-Jabbar)
10. https://www.islamicfinder.us/audios/asma-ul-husna/010.mp3  (Al-Mutakabbir)

... (continue pattern for 011.mp3 through 099.mp3)

99. https://www.islamicfinder.us/audios/asma-ul-husna/099.mp3  (As-Sabur)
```

**URL Pattern:**
```
https://www.islamicfinder.us/audios/asma-ul-husna/[NUMBER].mp3
```
Where [NUMBER] is 001 to 099 (with leading zeros)

---

## ✅ Verification

### Check Downloaded Files:

**Windows (Command Prompt):**
```cmd
dir assets\audio
```

**Mac/Linux (Terminal):**
```bash
ls -lh assets/audio/
```

**Expected Output:**
```
001.mp3  (200-300 KB)
002.mp3  (200-300 KB)
003.mp3  (200-300 KB)
...
099.mp3  (200-300 KB)

Total: 99 files, ~15-30 MB
```

### Verify File Count:

**Windows (PowerShell):**
```powershell
(Get-ChildItem assets\audio\*.mp3).Count
# Should output: 99
```

**Mac/Linux:**
```bash
ls assets/audio/*.mp3 | wc -l
# Should output: 99
```

---

## 🔧 After Download

### 1. Clean Flutter Build:
```bash
flutter clean
```

### 2. Get Dependencies:
```bash
flutter pub get
```

### 3. Run the App:
```bash
flutter run
```

### 4. Test Offline Mode:
- Enable airplane mode on your device
- Open the app
- Click play on any name
- Should play without internet!

---

## 🐛 Common Issues & Solutions

### Issue 1: "Python not found"
**Solution:**
- Install Python from https://www.python.org/
- During installation, check "Add Python to PATH"
- Restart terminal/command prompt

### Issue 2: "Permission denied"
**Solution (Mac/Linux):**
```bash
chmod +x download_audio.sh
chmod +x download_audio.py
```

### Issue 3: "Failed to download"
**Solutions:**
1. Check internet connection
2. Try running script again (it skips existing files)
3. Download manually from URLs above
4. Try alternative source:
   ```
   https://raw.githubusercontent.com/soachishti/Asma-ul-Husna/master/audio/[NUMBER].mp3
   ```

### Issue 4: "Audio not playing in app"
**Solutions:**
1. Verify files are in `assets/audio/` folder
2. Check file names: must be `001.mp3` not `1.mp3`
3. Run `flutter clean && flutter pub get`
4. Rebuild the app
5. Check `pubspec.yaml` includes `- assets/audio/`

### Issue 5: "Some files failed to download"
**Solution:**
- Run script again (it will retry only failed files)
- Or download failed files manually
- App will fallback to online sources for missing files

---

## 📊 Download Statistics

**Typical Download:**
- **Time:** 5-10 minutes (depends on internet speed)
- **Size:** 15-30 MB total
- **Files:** 99 MP3 files
- **Quality:** High-quality recitation
- **Format:** MP3, 128-192 kbps

**Internet Speed Estimates:**
- Fast (10+ Mbps): 3-5 minutes
- Medium (5-10 Mbps): 5-8 minutes
- Slow (1-5 Mbps): 10-15 minutes

---

## 🎯 Success Checklist

Before running your app, verify:

- [ ] Downloaded all 99 audio files
- [ ] Files are in `assets/audio/` folder
- [ ] Files are named correctly (001.mp3 to 099.mp3)
- [ ] Total file count is 99
- [ ] Total size is approximately 15-30 MB
- [ ] Ran `flutter clean`
- [ ] Ran `flutter pub get`
- [ ] Ready to test!

---

## 🚀 Next Steps

After successful download:

1. ✅ Run `flutter clean && flutter pub get`
2. ✅ Build and run your app
3. ✅ Test play button on any name
4. ✅ Test "Play All Names" feature
5. ✅ Test offline mode (airplane mode)
6. ✅ Enjoy beautiful offline recitations!

---

**Need Help?** Check `OFFLINE_AUDIO_SETUP.md` for detailed troubleshooting.
