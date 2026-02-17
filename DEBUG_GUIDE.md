# 🐛 Live Debugging Guide - Flutter

## 🔥 Hot Reload & Hot Restart

When you run `flutter run`, you get **live debugging** with instant updates!

### Quick Commands (While App is Running)

Press these keys in your terminal:

- **`r`** - Hot Reload (updates UI instantly, keeps state)
- **`R`** - Hot Restart (full restart, resets state)
- **`q`** - Quit (stops the app)
- **`d`** - Detach (app keeps running, terminal disconnects)
- **`h`** - Help (shows all commands)

---

## 🚀 Start Live Debugging Session

### Method 1: Run Directly (Recommended)
```bash
cd expense_tracker
flutter run -d "SM A135F"
```

This will:
- ✅ Build and install the app
- ✅ Launch it on your phone
- ✅ Connect debugger
- ✅ Enable hot reload
- ✅ Show console logs

### Method 2: Run with Verbose Logging
```bash
flutter run -d "SM A135F" -v
```

Shows detailed debug information.

### Method 3: Run with Specific Device ID
```bash
flutter run -d R58W211ZS3D
```

---

## 🔧 Live Debugging Workflow

### 1. Start the App
```bash
flutter run -d "SM A135F"
```

Wait for:
```
Flutter run key commands.
r Hot reload.
R Hot restart.
...
```

### 2. Make Code Changes

Edit any file in `lib/`, for example:
- Change a color in `lib/core/theme/app_theme.dart`
- Modify text in `lib/presentation/pages/home/home_page.dart`
- Update logic in `lib/presentation/bloc/expense/expense_bloc.dart`

### 3. Hot Reload (Press `r`)

In the terminal, press **`r`** and hit Enter:
```
r
Performing hot reload...
Reloaded 1 of 500 libraries in 234ms.
```

**Your phone updates INSTANTLY!** ⚡

### 4. Hot Restart (Press `R`)

If hot reload doesn't work (e.g., changed `main.dart`), press **`R`**:
```
R
Performing hot restart...
Restarted application in 1,234ms.
```

---

## 🖥️ Visual Studio Code Debugging

### Setup

1. Open `expense_tracker` folder in VS Code
2. Install **Flutter** and **Dart** extensions
3. Open `lib/main.dart`

### Start Debugging

**Option 1: Use Debug Panel**
1. Click the **Run and Debug** icon (left sidebar)
2. Click **"Start Debugging"** (or press `F5`)
3. Select your device: **SM A135F**

**Option 2: Use Status Bar**
1. Click device selector in bottom-right: **No Device**
2. Select **SM A135F**
3. Press `F5` to start debugging

### Debug Features

- **Breakpoints**: Click left of line numbers to add breakpoints
- **Step Through**: Use `F10` (step over), `F11` (step into)
- **Watch Variables**: Add variables to watch panel
- **Debug Console**: See print statements and errors
- **Hot Reload**: Save file (`Ctrl+S`) to hot reload automatically!

---

## 🔍 Debug Console Output

### View Logs

All `print()` statements appear in the terminal:

```dart
print('Expense added: ${expense.title}');
print('Current state: $state');
print('Database path: $path');
```

Output in terminal:
```
flutter: Expense added: Coffee
flutter: Current state: ExpenseLoadedState
flutter: Database path: /data/user/0/.../databases/expense_tracker.db
```

### Debug Statements

Add debug prints anywhere:

```dart
// In BLoC
print('🔵 LoadExpensesEvent triggered');

// In Repository
print('🟢 Fetching expenses from database...');

// In UI
print('🟡 Building ExpenseCard for: ${expense.title}');
```

---

## 🎯 Advanced Debugging

### 1. Flutter DevTools

Launch DevTools for advanced debugging:

```bash
flutter run -d "SM A135F"
```

Then open the URL shown:
```
The Flutter DevTools debugger and profiler on SM A135F is available at:
http://127.0.0.1:9100?uri=http://127.0.0.1:12345/abc123=
```

**DevTools Features:**
- 🎨 **Widget Inspector** - Inspect UI tree
- 📊 **Performance** - Profile frame rendering
- 💾 **Memory** - Track memory usage
- 🌐 **Network** - Monitor API calls
- 📝 **Logging** - Advanced log viewer

### 2. Debug Mode vs Release Mode

**Debug Mode** (default):
```bash
flutter run -d "SM A135F"
```
- ✅ Hot reload enabled
- ✅ Debug symbols included
- ✅ Assertions enabled
- ⚠️ Slower performance

**Profile Mode** (for performance testing):
```bash
flutter run -d "SM A135F" --profile
```
- ✅ Performance profiling
- ❌ No hot reload
- ✅ Optimized code

**Release Mode** (production):
```bash
flutter run -d "SM A135F" --release
```
- ✅ Full optimization
- ❌ No debugging
- ✅ Best performance

### 3. Breakpoint Debugging in VS Code

```dart
void _addExpense(Expense expense) {
  debugger(); // Pauses execution here
  print('Adding expense: ${expense.title}');
  // ... rest of code
}
```

Or use VS Code breakpoints (click left of line number).

---

## 🔄 Hot Reload Best Practices

### ✅ Hot Reload Works For:
- UI changes (widgets, layouts, colors)
- Text changes
- Adding new widgets
- Modifying existing functions
- Changing constants

### ❌ Hot Reload Doesn't Work For:
- Changes to `main()` function → Use **Hot Restart** (`R`)
- Adding new files → Use **Hot Restart**
- Changing app initialization → Use **Hot Restart**
- Native code changes → Rebuild app

### 💡 Pro Tips:
1. **Save often** - Each save triggers hot reload in VS Code
2. **Use `const`** - Makes hot reload faster
3. **Keep state** - Hot reload preserves app state
4. **Watch terminal** - Shows what was reloaded

---

## 🐞 Common Debug Scenarios

### Scenario 1: UI Not Updating

**Problem**: Changed UI code but nothing happens

**Solution**:
1. Press `r` for hot reload
2. If still not working, press `R` for hot restart
3. Check terminal for errors

### Scenario 2: State Issues

**Problem**: App state is wrong after hot reload

**Solution**:
1. Press `R` for hot restart (resets state)
2. Or restart app completely: `q` then `flutter run`

### Scenario 3: Database Issues

**Problem**: Database not updating

**Solution**:
```bash
# Clear app data
flutter run -d "SM A135F" --clear-cache

# Or uninstall and reinstall
flutter clean
flutter run -d "SM A135F"
```

### Scenario 4: Can't Find Device

**Problem**: Device not showing up

**Solution**:
```bash
# Check connected devices
flutter devices

# Reconnect USB cable
# Enable USB debugging on phone
# Run again
flutter run -d "SM A135F"
```

---

## 📱 Debug on Multiple Devices Simultaneously

### Run on Phone and Chrome
```bash
# Terminal 1
flutter run -d "SM A135F"

# Terminal 2 (new terminal)
flutter run -d chrome
```

Both will have hot reload!

---

## 🎨 Live UI Debugging

### Widget Inspector (VS Code)

1. Start debugging (`F5`)
2. Open **Flutter Inspector** panel
3. Click **"Select Widget Mode"**
4. Tap any widget on your phone
5. See widget tree, properties, and layout

### Performance Overlay

Add to your app:

```dart
MaterialApp(
  showPerformanceOverlay: true, // Shows FPS
  debugShowCheckedModeBanner: false,
  // ...
)
```

---

## 🔥 Quick Reference

| Action | Command | When to Use |
|--------|---------|-------------|
| Hot Reload | `r` | After UI changes |
| Hot Restart | `R` | After logic changes |
| Quit | `q` | Stop debugging |
| Detach | `d` | Keep app running |
| Help | `h` | Show all commands |
| Clear Screen | `c` | Clean terminal |

---

## 🚀 Start Debugging NOW!

```bash
cd expense_tracker
flutter run -d "SM A135F"
```

Then:
1. Edit `lib/presentation/pages/home/home_page.dart`
2. Change some text or color
3. Press `r` in terminal
4. **Watch your phone update instantly!** ⚡

---

## 💡 Pro Debugging Tips

1. **Use print statements liberally** - They're your best friend
2. **Hot reload after every small change** - Instant feedback
3. **Use VS Code debugger** - Set breakpoints, inspect variables
4. **Keep DevTools open** - Monitor performance
5. **Test on real device** - More accurate than emulator

---

**Happy Debugging!** 🐛🔧✨

Your app is live on your phone with full debugging support!

