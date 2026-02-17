# 🔨 Build Guide - Smart Expense Tracker

## Quick Build Commands

### For Development (Debug Mode)

#### Build APK
```bash
cd expense_tracker
flutter build apk --debug
```

#### Copy APK to Flutter's expected location
```powershell
New-Item -ItemType Directory -Force -Path "build\app\outputs\flutter-apk"
Copy-Item "android\app\build\outputs\flutter-apk\app-debug.apk" -Destination "build\app\outputs\flutter-apk\app-debug.apk" -Force
```

#### Install on Device
```bash
flutter install -d "SM A135F" --debug
```

#### Run with Hot Reload
```bash
flutter run -d "SM A135F" --use-application-binary="build\app\outputs\flutter-apk\app-debug.apk"
```

### For Production (Release Mode)

#### Build Release APK
```bash
flutter build apk --release
```

The release APK will be at:
```
build/app/outputs/flutter-apk/app-release.apk
```

#### Install Release APK
```bash
flutter install -d "SM A135F" --release
```

---

## One-Command Build & Run

### Debug
```bash
flutter run -d "SM A135F"
```

If you get "Gradle build failed to produce an .apk file" error, use the manual steps above.

### Release
```bash
flutter run -d "SM A135F" --release
```

---

## Build Outputs

### Debug APK Location
- **Android Build**: `android/app/build/outputs/flutter-apk/app-debug.apk`
- **Flutter Expected**: `build/app/outputs/flutter-apk/app-debug.apk`

### Release APK Location
- **Android Build**: `android/app/build/outputs/flutter-apk/app-release.apk`
- **Flutter Expected**: `build/app/outputs/flutter-apk/app-release.apk`

---

## Troubleshooting

### Issue: "Could not find io.flutter:armeabi_v7a_debug"
**Solution**: Already fixed in `settings.gradle.kts` with `PREFER_PROJECT` mode.

### Issue: "Gradle build failed to produce an .apk file"
**Solution**: The APK is actually built, just in the wrong location. Use the copy command above.

### Issue: Kotlin version warning
**Solution**: Already upgraded to Kotlin 2.1.0 in `settings.gradle.kts`.

### Issue: Build takes too long
**Solution**: 
```bash
flutter clean
flutter pub get
flutter build apk --debug
```

---

## Build Times

- **First Build**: ~5 minutes (downloads dependencies)
- **Incremental Build**: ~30 seconds
- **Clean Build**: ~3-4 minutes

---

## APK Sizes

- **Debug APK**: ~50-60 MB (includes debugging symbols)
- **Release APK**: ~20-30 MB (optimized and minified)
- **Release APK (split)**: ~10-15 MB per ABI

---

## Advanced: Split APKs by Architecture

For smaller APK sizes:

```bash
flutter build apk --split-per-abi --release
```

This creates separate APKs for:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit x86)

---

## Publishing to Google Play

### 1. Create App Bundle
```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 2. Sign the Bundle
Already signed with debug key. For production, configure signing in:
- `android/app/build.gradle.kts`
- `android/key.properties`

### 3. Upload to Play Console
- Go to Google Play Console
- Upload the `.aab` file
- Fill in store listing details
- Submit for review

---

## Your App is Ready! 🚀

The app is now:
- ✅ Built successfully
- ✅ Installed on your phone
- ✅ Running with all features
- ✅ Ready for development or release

Enjoy your Smart Expense Tracker! 💰📊✨

