r# 📱 App Icon Setup Instructions

## Current Status
The app currently uses the default Flutter icon. To add a custom icon for "Expense Tracker", follow these steps:

## Option 1: Quick Setup (Recommended)

### Step 1: Create Your Icon
1. Go to https://icon.kitchen/ or https://appicon.co/
2. Design your icon with:
   - **Icon**: Wallet or money symbol
   - **Background Color**: #6366F1 (Indigo - matches your app theme)
   - **Foreground**: White wallet icon
3. Download the Android icon pack

### Step 2: Replace Icons
1. Extract the downloaded zip file
2. Copy the contents to: `expense_tracker/android/app/src/main/res/`
3. This will replace all mipmap folders (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)

### Step 3: Rebuild
```bash
flutter clean
flutter run
```

## Option 2: Using flutter_launcher_icons Package

### Step 1: Prepare Icon Image
1. Create a 1024x1024 PNG image for your app icon
2. Save it as `assets/icon/app_icon.png`
3. Create a foreground-only version (transparent background) as `assets/icon/app_icon_foreground.png`

### Step 2: Generate Icons
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Step 3: Rebuild
```bash
flutter clean
flutter run
```

## Icon Design Recommendations

### Colors
- **Background**: #6366F1 (Indigo - your app's primary color)
- **Icon**: White (#FFFFFF)
- **Style**: Modern, minimalist

### Icon Ideas
1. 💰 **Wallet Icon**: Simple wallet outline
2. 💳 **Card Icon**: Credit card with dollar sign
3. 📊 **Chart Icon**: Bar chart with money symbol
4. 💵 **Money Icon**: Dollar bill or coins
5. 📝 **Receipt Icon**: Receipt with checkmark

### Best Practices
- Keep it simple and recognizable
- Use high contrast (white on indigo works great)
- Avoid text in icons
- Test on different backgrounds
- Make sure it's visible at small sizes

## Current Configuration

The `pubspec.yaml` is already configured with:
```yaml
flutter_launcher_icons:
  android: true
  ios: false
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#6366F1"
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

## Quick Icon Resources

### Free Icon Generators
- https://icon.kitchen/ - Best for Android adaptive icons
- https://appicon.co/ - Multi-platform icon generator
- https://www.canva.com/ - Design custom icons

### Free Icon Libraries
- https://fonts.google.com/icons - Material Icons
- https://fontawesome.com/ - Font Awesome
- https://www.flaticon.com/ - Flaticon

## Need Help?

If you have an icon image ready:
1. Place it in `assets/icon/app_icon.png` (1024x1024)
2. Run: `flutter pub run flutter_launcher_icons`
3. Rebuild the app

The icon will automatically be generated for all required sizes!

