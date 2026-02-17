# 💰 Smart Expense Tracker

A beautiful and feature-rich expense tracking application built with **Flutter** using **Clean Architecture** and **Domain-Driven Design (DDD)** principles.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-orange" alt="Architecture">
  <img src="https://img.shields.io/badge/State%20Management-BLoC-purple" alt="BLoC">
</p>

## ✨ Features

### 📊 Expense Management
- ✅ **Add, Edit, Delete** expenses with validation
- ✅ **8 Predefined Categories** with colorful icons
  - 🍔 Food | 🚗 Transport | 🛍️ Shopping | 🎬 Entertainment
  - 📄 Bills | 🏥 Health | 🎓 Education | ⋯ Others
- ✅ **Date Picker** for easy date selection
- ✅ **Optional Notes** for additional details
- ✅ **Real-time Updates** with instant feedback

### 📈 Analytics & Visualization
- ✅ **Interactive Pie Chart** showing spending by category
- ✅ **Trend Bar Chart** displaying spending patterns
- ✅ **Period Selector** - Daily, Weekly, Monthly views
- ✅ **Summary Cards** with total and average spending
- ✅ **Top Categories** ranking with percentages
- ✅ **Beautiful Animations** and smooth transitions

### 🎨 User Interface
- ✅ **Material 3 Design** with modern aesthetics
- ✅ **Dark/Light Mode** toggle for comfortable viewing
- ✅ **Responsive Layout** adapting to all screen sizes
- ✅ **Smooth Animations** and intuitive navigation
- ✅ **Beautiful Gradients** and color schemes

### 💾 Data Management
- ✅ **SQLite Database** for local data persistence
- ✅ **Export to CSV** for spreadsheet analysis
- ✅ **Export to PDF** with professional reports including:
  - Summary section with totals
  - Category breakdown table
  - Complete expense list
- ✅ **Auto-save** functionality
- ✅ **File Permissions** handling

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **Domain-Driven Design (DDD)**:

```
┌─────────────────────────────────────────┐
│       PRESENTATION LAYER                │
│   • BLoC (State Management)             │
│   • Pages (UI Screens)                  │
│   • Widgets (Reusable Components)       │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│         DOMAIN LAYER                    │
│   • Entities (Business Models)          │
│   • Use Cases (Business Logic)          │
│   • Repository Interfaces               │
└─────────────────────────────────────────┘
                  ↑
┌─────────────────────────────────────────┐
│          DATA LAYER                     │
│   • Models (Data Transfer Objects)      │
│   • Data Sources (SQLite)               │
│   • Repository Implementations          │
└─────────────────────────────────────────┘
```

### 📁 Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── di/                 # Dependency Injection (GetIt)
│   ├── database/           # Database configuration
│   ├── error/              # Error handling & failures
│   └── usecases/           # Base use case classes
├── domain/                  # Business Logic Layer
│   ├── entities/           # Business entities (Expense, Category)
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business use cases (8 use cases)
├── data/                    # Data Layer
│   ├── models/             # Data models with mappers
│   ├── datasources/        # SQLite data source
│   └── repositories/       # Repository implementations
└── presentation/            # Presentation Layer
    ├── bloc/               # BLoC state management
    ├── pages/              # UI screens
    └── widgets/            # Reusable widgets
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions
- Android device/emulator or iOS simulator

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/expense_tracker.git
cd expense_tracker
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# On connected device
flutter run

# On specific device
flutter devices
flutter run -d <device-id>

# On Chrome (web)
flutter run -d chrome
```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📦 Dependencies

### Core
- **flutter_bloc** (^8.1.3) - State management
- **equatable** (^2.0.5) - Value equality
- **get_it** (^7.6.4) - Dependency injection
- **dartz** (^0.10.1) - Functional programming

### Data & Storage
- **sqflite** (^2.3.0) - Local database
- **path_provider** (^2.1.1) - File system paths
- **path** (^1.8.3) - Path manipulation

### UI & Visualization
- **fl_chart** (^0.65.0) - Beautiful charts
- **intl** (^0.18.1) - Internationalization

### Export & Files
- **csv** (^5.1.1) - CSV generation
- **pdf** (^3.10.7) - PDF generation
- **open_file** (^3.3.2) - File opening
- **permission_handler** (^11.0.1) - Permissions

## 🎯 Key Design Patterns

### 1. **Repository Pattern**
Abstracts data sources and provides a clean API for data access.

### 2. **Use Case Pattern**
Each business operation is encapsulated in a single-responsibility use case.

### 3. **BLoC Pattern**
Predictable state management with clear separation of business logic and UI.

### 4. **Dependency Injection**
Loose coupling using GetIt service locator for better testability.

### 5. **Either Pattern**
Type-safe error handling without exceptions using `dartz`.

## 🎓 What Makes This Project Special?

### Professional Architecture
This isn't just a tutorial app - it uses **production-ready architecture** patterns:

1. **Clean Architecture** - Industry-standard separation of concerns
2. **DDD** - Domain-driven design principles
3. **BLoC** - Predictable and testable state management
4. **SOLID** - All five principles applied
5. **Dependency Injection** - Loose coupling for testability

### Scalability
- Easy to add new features without breaking existing code
- Can swap implementations (e.g., SQLite → Hive)
- Can add remote API without changing domain layer
- Testable at every layer

### Best Practices
- Type-safe error handling with `Either`
- Immutable state
- Single responsibility principle
- Interface segregation
- Dependency inversion

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Naol Kecha**
- GitHub: [@naolkecha](https://github.com/naolkecha)


## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Community packages that made this possible
- Clean Architecture principles by Robert C. Martin

## 📚 Additional Documentation

- [Architecture Documentation](ARCHITECTURE.md) - Detailed architecture guide
- [Project Structure](PROJECT_STRUCTURE.md) - File organization
- [Quick Start Guide](QUICK_START.md) - Development guide
- [Final Summary](FINAL_SUMMARY.md) - Complete feature list

## 🔮 Future Enhancements

- [ ] User authentication & multi-user support
- [ ] Cloud sync with Firebase/Supabase
- [ ] Budget goals and alerts
- [ ] Recurring expenses
- [ ] Receipt scanner with OCR
- [ ] Multi-currency support
- [ ] Data backup to cloud
- [ ] Share reports via email
- [ ] Spending insights with AI
- [ ] Widget for home screen

## 📞 Support

If you find this project helpful, please give it a ⭐️!

For issues and questions, please use the [GitHub Issues](https://github.com/yourusername/expense_tracker/issues) page.

---

<p align="center">Made with ❤️ using Flutter</p>
<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Built%20with-Flutter-02569B?logo=flutter" alt="Built with Flutter">
  </a>
</p>
