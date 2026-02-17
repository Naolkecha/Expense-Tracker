# 🔧 Troubleshooting Guide

## White Screen on Chrome/Web

If you see a white screen when running on Chrome, follow these steps:

### Step 1: Check Browser Console
1. Open Chrome DevTools (Press **F12**)
2. Go to **Console** tab
3. Look for error messages

### Common Issues:

#### Issue 1: sqflite_sw.js not found
**Error**: `Failed to find worker javascript file at sqflite_sw.js`

**Solution**: The web worker file is in `web/sqflite_sw.js`. Make sure it exists.

#### Issue 2: Database initialization failed
**Error**: `databaseFactory not initialized`

**Solution**: This is fixed in the latest code. Try:
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

#### Issue 3: CORS or network errors
**Error**: Network-related errors

**Solution**: Some features (like export) may not work on web. Use mobile/desktop for full functionality.

## Quick Fix: Run on Mobile Instead

The app works best on mobile devices. To run on your phone:

```bash
# Make sure phone is connected via USB
flutter devices

# Run on phone
flutter run -d <device-id>
```

## Alternative: Run on Windows Desktop

```bash
flutter run -d windows
```

This works perfectly with all features!

## Still Having Issues?

### Option 1: Check Flutter Doctor
```bash
flutter doctor -v
```

### Option 2: Clean Everything
```bash
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
flutter run
```

### Option 3: Use Release Mode
```bash
flutter run --release -d <device>
```

## Known Limitations

### Web Platform
- ✅ All UI features work
- ✅ Database works (IndexedDB)
- ⚠️ Export may have limitations
- ⚠️ File permissions not available

### Mobile Platform (Recommended)
- ✅ All features work perfectly
- ✅ Export to CSV/PDF
- ✅ File permissions
- ✅ Best performance

### Desktop Platform
- ✅ All features work
- ✅ Export functionality
- ✅ Good for development

## Contact

If you continue to have issues, please:
1. Check the error in browser console (F12)
2. Share the error message
3. Try running on mobile device instead

## Success Indicators

When the app works correctly, you should see:
- ✅ "Smart Expense Tracker" title
- ✅ Theme toggle icon
- ✅ Analytics icon
- ✅ "No expenses yet" message
- ✅ Blue + button at bottom

If you see this, the app is working! 🎉

