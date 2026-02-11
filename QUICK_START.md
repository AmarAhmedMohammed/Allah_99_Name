# Quick Start - Offline Audio Setup

## 🚀 Get Started in 3 Minutes

### For Windows Users:

1. **Double-click** `download_audio.bat`
2. Wait for download to complete (5-10 minutes)
3. Run your app: `flutter run`

### For Mac/Linux Users:

```bash
chmod +x download_audio.sh
./download_audio.sh
flutter run
```

### For Python Users:

```bash
python3 download_audio.py
flutter run
```

## ✅ What You Get

- 99 beautiful recitations downloaded locally
- Offline playback (no internet needed)
- Instant audio playback (no buffering)
- Automatic fallback to online if needed

## 📁 File Structure After Download

```
your_project/
├── assets/
│   └── audio/
│       ├── 001.mp3  ✓
│       ├── 002.mp3  ✓
│       ├── 003.mp3  ✓
│       └── ... (99 files total)
├── download_audio.py
├── download_audio.bat
└── download_audio.sh
```

## 🎵 How to Use in App

1. **Single Name:** Click play button on any name card
2. **All Names:** Click "Play All Names" button
3. **Works Offline:** Enable airplane mode and test!

## ⚡ Quick Test

After downloading:

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run

# In the app:
# 1. Click "Start Learning"
# 2. Click play button on first name
# 3. Should play instantly without loading!
```

## 🔧 Troubleshooting

**Audio not playing?**
```bash
# Verify files exist
ls assets/audio/

# Should show: 001.mp3, 002.mp3, ..., 099.mp3

# Rebuild
flutter clean
flutter pub get
flutter run
```

**Download failed?**
- Check internet connection
- Run script again (it skips existing files)
- Try manual download from: https://www.islamicfinder.us/audios/asma-ul-husna/001.mp3

## 📊 Expected Results

- **Download Time:** 5-10 minutes
- **Total Size:** ~15-30 MB
- **Files:** 99 MP3 files
- **Quality:** High-quality recitation

## 🎯 Success Indicators

✅ Script shows "All audio files downloaded successfully!"
✅ `assets/audio/` folder contains 99 MP3 files
✅ App plays audio instantly without loading spinner
✅ Works in airplane mode

---

**That's it! Enjoy beautiful offline recitations! 🎵**
