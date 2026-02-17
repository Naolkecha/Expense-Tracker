# Project Structure

## Complete Directory Tree

```
expense_tracker/
│
├── lib/                                    # Source code
│   ├── main.dart                          # App entry point
│   │
│   ├── core/                              # Core functionality (shared)
│   │   ├── di/
│   │   │   └── injection_container.dart   # Dependency injection setup
│   │   ├── database/
│   │   │   └── database_helper.dart       # SQLite database initialization
│   │   ├── error/
│   │   │   └── failures.dart              # Failure classes
│   │   └── usecases/
│   │       └── usecase.dart               # Base use case class
│   │
│   ├── domain/                            # Business logic layer (pure Dart)
│   │   ├── entities/
│   │   │   ├── expense.dart               # Expense entity
│   │   │   └── category.dart              # Category definitions
│   │   ├── repositories/
│   │   │   └── expense_repository.dart    # Repository interface
│   │   └── usecases/
│   │       ├── add_expense.dart           # Add expense use case
│   │       ├── update_expense.dart        # Update expense use case
│   │       ├── delete_expense.dart        # Delete expense use case
│   │       ├── get_all_expenses.dart      # Get all expenses use case
│   │       ├── get_expenses_by_date_range.dart
│   │       └── get_expenses_by_category.dart
│   │
│   ├── data/                              # Data layer
│   │   ├── models/
│   │   │   └── expense_model.dart         # Data model with mappers
│   │   ├── datasources/
│   │   │   └── expense_local_data_source.dart  # SQLite operations
│   │   └── repositories/
│   │       └── expense_repository_impl.dart    # Repository implementation
│   │
│   └── presentation/                      # Presentation layer (UI)
│       ├── bloc/
│       │   ├── expense/
│       │   │   ├── expense_bloc.dart      # Expense BLoC
│       │   │   ├── expense_event.dart     # Expense events
│       │   │   └── expense_state.dart     # Expense states
│       │   └── theme/
│       │       ├── theme_bloc.dart        # Theme BLoC
│       │       ├── theme_event.dart       # Theme events
│       │       └── theme_state.dart       # Theme states
│       ├── pages/
│       │   ├── home/
│       │   │   └── home_page.dart         # Main home screen
│       │   └── expense/
│       │       └── add_expense_page.dart  # Add/Edit expense screen
│       └── widgets/
│           ├── summary_card.dart          # Summary card widget
│           └── expense_card.dart          # Expense item widget
│
├── pubspec.yaml                           # Dependencies
├── analysis_options.yaml                  # Linter configuration
├── .gitignore                            # Git ignore rules
│
└── Documentation/
    ├── README.md                         # Project overview
    ├── ARCHITECTURE.md                   # Architecture documentation
    ├── QUICK_START.md                    # Quick start guide
    ├── PHASE_1_SUMMARY.md               # Phase 1 summary
    └── PROJECT_STRUCTURE.md             # This file
```

## Layer Dependencies

```
┌─────────────────────────────────────────┐
│         PRESENTATION LAYER              │
│  (BLoC, Pages, Widgets)                 │
│                                         │
│  Dependencies: domain/                  │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│           DOMAIN LAYER                  │
│  (Entities, Use Cases, Repositories)    │
│                                         │
│  Dependencies: NONE (Pure Dart)         │
└─────────────────────────────────────────┘
                  ↑
┌─────────────────────────────────────────┐
│            DATA LAYER                   │
│  (Models, Data Sources, Repositories)   │
│                                         │
│  Dependencies: domain/                  │
└─────────────────────────────────────────┘
```

## File Purposes

### Core Layer

| File | Purpose | Dependencies |
|------|---------|-------------|
| `injection_container.dart` | Sets up dependency injection with GetIt | All layers |
| `database_helper.dart` | Initializes SQLite database | sqflite |
| `failures.dart` | Defines failure types for error handling | equatable |
| `usecase.dart` | Base class for all use cases | dartz |

### Domain Layer

| File | Purpose | Dependencies |
|------|---------|-------------|
| `expense.dart` | Core expense entity | equatable |
| `category.dart` | Category definitions with icons | flutter/material |
| `expense_repository.dart` | Repository contract | dartz, entities |
| `add_expense.dart` | Business logic for adding expense | repository |
| `update_expense.dart` | Business logic for updating expense | repository |
| `delete_expense.dart` | Business logic for deleting expense | repository |
| `get_all_expenses.dart` | Business logic for fetching expenses | repository |
| `get_expenses_by_date_range.dart` | Filter expenses by date | repository |
| `get_expenses_by_category.dart` | Group expenses by category | repository |

### Data Layer

| File | Purpose | Dependencies |
|------|---------|-------------|
| `expense_model.dart` | Data model with serialization | domain/entities |
| `expense_local_data_source.dart` | SQLite CRUD operations | sqflite, models |
| `expense_repository_impl.dart` | Repository implementation | domain, datasources |

### Presentation Layer

| File | Purpose | Dependencies |
|------|---------|-------------|
| `expense_bloc.dart` | State management for expenses | domain/usecases |
| `expense_event.dart` | Events for expense operations | equatable |
| `expense_state.dart` | States for expense UI | equatable, entities |
| `theme_bloc.dart` | State management for theme | flutter_bloc |
| `theme_event.dart` | Events for theme operations | equatable |
| `theme_state.dart` | States for theme UI | equatable, material |
| `home_page.dart` | Main screen UI | bloc, widgets |
| `add_expense_page.dart` | Add/Edit expense UI | bloc, entities |
| `summary_card.dart` | Summary display widget | intl |
| `expense_card.dart` | Expense item widget | intl, entities |

## Data Flow Example

### Adding an Expense

```
1. User fills form in add_expense_page.dart
   ↓
2. User taps "Add Expense" button
   ↓
3. Page dispatches AddExpenseEvent to expense_bloc.dart
   ↓
4. BLoC calls AddExpense use case (domain/usecases/)
   ↓
5. Use case calls ExpenseRepository interface (domain/repositories/)
   ↓
6. Repository implementation (data/repositories/) is called
   ↓
7. Repository calls ExpenseLocalDataSource (data/datasources/)
   ↓
8. Data source inserts into SQLite database
   ↓
9. Success/Failure returned up the chain via Either<Failure, Success>
   ↓
10. BLoC emits new state (ExpenseLoaded or ExpenseError)
   ↓
11. UI rebuilds based on new state
   ↓
12. User sees updated expense list
```

## State Management Flow

```
┌──────────────┐
│   UI Event   │  User taps button
└──────┬───────┘
       ↓
┌──────────────┐
│  BLoC Event  │  AddExpenseEvent
└──────┬───────┘
       ↓
┌──────────────┐
│   Use Case   │  AddExpense.call()
└──────┬───────┘
       ↓
┌──────────────┐
│  Repository  │  ExpenseRepository.addExpense()
└──────┬───────┘
       ↓
┌──────────────┐
│ Data Source  │  SQLite insert
└──────┬───────┘
       ↓
┌──────────────┐
│    Result    │  Either<Failure, Success>
└──────┬───────┘
       ↓
┌──────────────┐
│  BLoC State  │  ExpenseLoaded
└──────┬───────┘
       ↓
┌──────────────┐
│  UI Rebuild  │  Display updated list
└──────────────┘
```

## Key Design Patterns

### 1. Repository Pattern
- **Interface**: `domain/repositories/expense_repository.dart`
- **Implementation**: `data/repositories/expense_repository_impl.dart`
- **Benefit**: Abstracts data source, easy to swap implementations

### 2. Use Case Pattern
- **Location**: `domain/usecases/`
- **Pattern**: One class per business operation
- **Benefit**: Single responsibility, easy to test

### 3. BLoC Pattern
- **Location**: `presentation/bloc/`
- **Pattern**: Event → BLoC → State
- **Benefit**: Predictable state management, separation of concerns

### 4. Dependency Injection
- **Location**: `core/di/injection_container.dart`
- **Pattern**: Service locator with GetIt
- **Benefit**: Loose coupling, easy to test

### 5. Either Pattern
- **Usage**: All repository methods return `Either<Failure, T>`
- **Benefit**: Type-safe error handling, no exceptions

## Testing Strategy

### Unit Tests (Domain Layer)
```
test/
├── domain/
│   ├── usecases/
│   │   ├── add_expense_test.dart
│   │   ├── update_expense_test.dart
│   │   └── delete_expense_test.dart
│   └── entities/
│       └── expense_test.dart
```

### Repository Tests (Data Layer)
```
test/
├── data/
│   ├── repositories/
│   │   └── expense_repository_impl_test.dart
│   └── datasources/
│       └── expense_local_data_source_test.dart
```

### BLoC Tests (Presentation Layer)
```
test/
├── presentation/
│   └── bloc/
│       ├── expense_bloc_test.dart
│       └── theme_bloc_test.dart
```

### Widget Tests
```
test/
├── presentation/
│   ├── pages/
│   │   ├── home_page_test.dart
│   │   └── add_expense_page_test.dart
│   └── widgets/
│       ├── summary_card_test.dart
│       └── expense_card_test.dart
```

## Code Metrics

### Lines of Code by Layer

| Layer | Files | Approx. LOC | Percentage |
|-------|-------|-------------|------------|
| Domain | 8 | 400 | 27% |
| Data | 3 | 300 | 20% |
| Presentation | 10 | 600 | 40% |
| Core | 4 | 200 | 13% |
| **Total** | **25** | **~1,500** | **100%** |

### Complexity Distribution

| Layer | Complexity | Testability |
|-------|------------|-------------|
| Domain | Low | High |
| Data | Medium | High |
| Presentation | Medium | Medium |
| Core | Low | High |

## Adding New Features

### To Add a New Use Case:

1. Create use case in `domain/usecases/`
2. Add method to repository interface in `domain/repositories/`
3. Implement method in `data/repositories/`
4. Register in `core/di/injection_container.dart`
5. Use in BLoC

### To Add a New Screen:

1. Create page in `presentation/pages/`
2. Create widgets in `presentation/widgets/` (if needed)
3. Connect to existing BLoC or create new one
4. Add navigation

### To Change Data Source:

1. Create new data source in `data/datasources/`
2. Update repository implementation
3. Update dependency injection
4. **Domain layer remains unchanged!**

## Best Practices Applied

✅ **SOLID Principles**
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

✅ **Clean Code**
- Meaningful names
- Small functions
- Clear comments
- Consistent formatting

✅ **DRY (Don't Repeat Yourself)**
- Reusable widgets
- Base classes
- Shared utilities

✅ **KISS (Keep It Simple, Stupid)**
- Simple, clear code
- No over-engineering
- Readable structure

## Conclusion

This structure provides:
- ✅ Clear separation of concerns
- ✅ High testability
- ✅ Easy maintenance
- ✅ Scalability
- ✅ Professional quality

Perfect foundation for a production app! 🚀




