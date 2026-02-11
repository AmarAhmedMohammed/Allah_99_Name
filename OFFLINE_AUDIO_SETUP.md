# Offline Audio Setup Guide

## Overview
This guide will help you download all 99 beautiful recitations of Allah's names to enable **offline playback** in your app.

## Why Offline Audio?

✅ **No Internet Required** - Users can listen anytime, anywhere
✅ **Faster Playback** - Instant audio without buffering
✅ **Better User Experience** - No loading delays
✅ **Data Savings** - No repeated downloads
✅ **Reliable** - Works even in poor network conditions

## Quick Setup (3 Steps)

### Step 1: Download Audio Files

#### Option A: Using Python Script (Recommended)

**Windows:**
```bash
# Double-click the file or run in terminal:
download_audio.bat
```

**Mac/Linux:**
```bash
# Make script executable
chmod +x download_audio.py

# Run the script
python3 download_audio.py
```

#### Option B: Manual Download

If you prefer, you can manually download files from:
- https://www.islamicfinder.us/audios/asma-ul-husna/001.mp3
- https://www.islamicfinder.us/audios/asma-ul-husna/002.mp3
- ... (continue to 099.mp3)

Save them in: `assets/audio/` folder with names: `001.mp3`, `002.mp3`, ..., `099.mp3`

### Step 2: Verify Files

After download, check that you have:
```
assets/audio/
├── 001.mp3  (Ar-Rahman)
├── 002.mp3  (Ar-Rahim)
├── 003.mp3  (Al-Malik)
├── ...
└── 099.mp3  (As-Sabur)
```

**Total:** 99 MP3 files
**Expected Size:** ~15-30 MB total

### Step 3: Build the App

```bash
# Clean previous build
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## How It Works

### Before (Online Mode)
```
User clicks play → App downloads from internet → Plays audio
                    ↓ (slow, requires internet)
```

### After (Offline Mode)
```
User clicks play → App loads from local storage → Plays audio
                    ↓ (instant, no internet needed)
```

## Download Script Features

The `download_audio.py` script:
- ✅ Downloads all 99 audio files automatically
- ✅ Tries multiple sources if one fails
- ✅ Skips already downloaded files
- ✅ Shows progress for each file
- ✅ Provides summary at the end
- ✅ Handles errors gracefully

### Script Output Example:
```
============================================================
Downloading Beautiful Recitations of Allah's 99 Names
============================================================

[1/99] Downloading 001.mp3...
  Source: Islamic Finder
  Trying: https://www.islamicfinder.us/audios/asma-ul-husna/001.mp3
  ✓ Downloaded (245,678 bytes)

[2/99] Downloading 002.mp3...
  Source: Islamic Finder
  Trying: https://www.islamicfinder.us/audios/asma-ul-husna/002.mp3
  ✓ Downloaded (198,432 bytes)

...

============================================================
DOWNLOAD SUMMARY
============================================================
✓ Successful: 99/99
✗ Failed: 0/99

🎉 All audio files downloaded successfully!
📁 Location: D:\Allah_99_Name\allah_name\assets\audio
```

## Troubleshooting

### Problem: Python not found
**Solution:** Install Python from https://www.python.org/
- Make sure to check "Add Python to PATH" during installation

### Problem: Download fails for some files
**Solution:** 
1. Run the script again (it will retry failed files)
2. Check your internet connection
3. Try downloading manually from alternative sources

### Problem: Audio not playing in app
**Solution:**
1. Verify files are in `assets/audio/` folder
2. Check file names are formatted correctly (001.mp3, not 1.mp3)
3. Run `flutter clean` and `flutter pub get`
4. Rebuild the app

### Problem: "Failed to load asset"
**Solution:**
1. Make sure `pubspec.yaml` includes: `- assets/audio/`
2. Run `flutter pub get`
3. Restart the app

## File Naming Convention

**Important:** Files must be named with 3 digits:
- ✅ Correct: `001.mp3`, `002.mp3`, `099.mp3`
- ❌ Wrong: `1.mp3`, `2.mp3`, `99.mp3`

## Fallback System

The app has a smart fallback system:

1. **Try Local Asset** (offline) - Fastest
2. **Try Online Source 1** - Islamic Finder
3. **Try Online Source 2** - GitHub
4. **Try Online Source 3** - Alternative CDN
5. **Use Text-to-Speech** - Final fallback

This means even if some audio files are missing, the app will still work!

## App Size Impact

Adding audio files will increase your app size:
- **Audio files:** ~15-30 MB
- **App without audio:** ~10-20 MB
- **App with audio:** ~25-50 MB

This is acceptable for the benefit of offline playback.

## Testing Offline Mode

To test that offline mode works:

1. Download all audio files
2. Build and run the app
3. Enable airplane mode on your device
4. Try playing different names
5. All should play without internet!

## Updating Audio Files

To update or replace audio files:

1. Delete old files from `assets/audio/`
2. Run download script again
3. Or manually replace specific files
4. Run `flutter clean` and rebuild

## Alternative: Hybrid Approach

You can also use a hybrid approach:
- Include only popular names (1-10) in the app
- Download others on-demand
- Cache downloaded files for offline use

This reduces initial app size while still providing offline capability.

## Production Checklist

Before releasing your app:

- [ ] All 99 audio files downloaded
- [ ] Files are correctly named (001-099)
- [ ] Files are in `assets/audio/` folder
- [ ] `pubspec.yaml` includes audio assets
- [ ] Tested playback for multiple names
- [ ] Tested offline mode (airplane mode)
- [ ] App builds without errors
- [ ] Audio quality is acceptable

## Support

If you encounter issues:
1. Check this guide's troubleshooting section
2. Verify file structure and naming
3. Check Flutter console for error messages
4. Ensure all dependencies are installed

---

**Ready to provide beautiful offline recitations! 🎵**
