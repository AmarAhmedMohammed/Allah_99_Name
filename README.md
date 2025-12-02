# Asma'ul Husna - Allah's 99 Beautiful Names

A beautiful, modern Flutter mobile application for learning Allah's 99 Names with audio pronunciation, meanings, and explanations.

## Features ✨

- 📱 Beautiful Islamic UI with gold + dark green theme
- 🎯 All 99 Names with Arabic text, transliteration, and meanings
- 🔊 Text-to-Speech audio for each name (Arabic pronunciation)
- 🎵 "Play All" mode with sequential playback
- 🔍 Search functionality
- 🌙 Dark/Light mode toggle
- 📖 Detailed explanations for each name
- 🎨 Responsive grid layout
- ⚡ Smooth animations

## Quick Start 🚀

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build APK
flutter build apk --release
```

## Project Structure 📁

```
lib/
├── main.dart                    # App entry
├── models/                      # Data models
├── providers/                   # State management
├── screens/                     # UI screens
├── constants/                   # App constants
└── utils/                       # Utilities

assets/
└── data/
    └── names.json              # 99 names data
```

## Screens 📱

1. **Home** - Welcome with Islamic design
2. **Names List** - Grid of all 99 names with search
3. **Name Detail** - Full details with audio
4. **Audio Player** - Sequential playback

## Technologies Used 🛠️

- Flutter & Dart
- Provider (State Management)
- Google Fonts (Arabic typography)
- Flutter TTS (Text-to-Speech)
- Shared Preferences (Local storage)

## Data 📊

All 99 names are stored in `assets/data/names.json` with:
- Arabic text
- Transliteration
- English meaning
- Amharic meaning
- Detailed explanation

## Islamic Reference 🕌

> "Indeed, Allah has ninety-nine names, one hundred less one. Whoever encompasses them will enter Paradise."
> - Sahih Bukhari

---

**May Allah accept this work. Ameen.** 🤲
