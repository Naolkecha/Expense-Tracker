# Architecture Documentation

## DDD Clean Architecture Overview

This project follows **Domain-Driven Design (DDD)** with **Clean Architecture** principles.

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    BLoC      │  │    Pages     │  │   Widgets    │      │
│  │ (State Mgmt) │  │   (Screens)  │  │ (UI Components)     │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Entities   │  │  Use Cases   │  │ Repositories │      │
│  │ (Pure Dart)  │  │ (Business    │  │ (Interfaces) │      │
│  │              │  │   Logic)     │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                      DATA LAYER                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    Models    │  │ Data Sources │  │ Repositories │      │
│  │ (Mappers)    │  │  (SQLite)    │  │(Implementation)     │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

## Layer Responsibilities

### 1. Presentation Layer (`lib/presentation/`)
**Responsibility**: UI and user interaction

- **BLoC**: Manages state and handles user events
- **Pages**: Full-screen views
- **Widgets**: Reusable UI components

**Dependencies**: Domain layer only

### 2. Domain Layer (`lib/domain/`)
**Responsibility**: Business logic (framework-independent)

- **Entities**: Core business objects (Expense, Category)
- **Use Cases**: Single-responsibility business operations
  - `AddExpense`
  - `UpdateExpense`
  - `DeleteExpense`
  - `GetAllExpenses`
  - `GetExpensesByDateRange`
  - `GetExpensesByCategory`
- **Repositories**: Interfaces (contracts) for data operations

**Dependencies**: None (pure Dart)

### 3. Data Layer (`lib/data/`)
**Responsibility**: Data management and external services

- **Models**: Data transfer objects with serialization
- **Data Sources**: Direct database/API interaction
- **Repositories**: Implementation of domain repository interfaces

**Dependencies**: Domain layer only

### 4. Core Layer (`lib/core/`)
**Responsibility**: Shared functionality

- **DI (Dependency Injection)**: Service locator setup with GetIt
- **Database**: Database initialization and configuration
- **Error**: Failure classes and error handling
- **Use Cases**: Base use case classes

## Data Flow

### Adding an Expense (Example)

```
User Action (UI)
      ↓
AddExpenseEvent (BLoC)
      ↓
AddExpense Use Case (Domain)
      ↓
ExpenseRepository Interface (Domain)
      ↓
ExpenseRepositoryImpl (Data)
      ↓
ExpenseLocalDataSource (Data)
      ↓
SQLite Database
      ↓
Return Either<Failure, Success>
      ↓
Update State (BLoC)
      ↓
Rebuild UI
```

## Key Design Patterns

### 1. Repository Pattern
- Abstracts data source details
- Domain defines interface, Data implements it

### 2. Use Case Pattern
- Single responsibility principle
- Each use case = one business operation

### 3. BLoC Pattern
- Separates business logic from UI
- Reactive state management with streams

### 4. Dependency Injection
- GetIt service locator
- Loose coupling between layers

### 5. Either Pattern (Functional Programming)
- Type-safe error handling
- `Either<Failure, Success>`
- No exceptions in business logic

## Benefits

### ✅ Testability
Each layer can be tested independently:
- **Domain**: Pure business logic tests
- **Data**: Repository and data source tests
- **Presentation**: Widget and BLoC tests

### ✅ Maintainability
- Clear separation of concerns
- Easy to locate and fix bugs
- Changes in one layer don't affect others

### ✅ Scalability
- Easy to add new features
- Can swap implementations (e.g., SQLite → Hive)
- Can add remote data sources without changing domain

### ✅ Independence
- **UI Independent**: Can change Flutter to another framework
- **Database Independent**: Can switch from SQLite to any database
- **Framework Independent**: Business logic is pure Dart

## File Structure

```
lib/
├── core/
│   ├── di/
│   │   └── injection_container.dart      # DI setup
│   ├── database/
│   │   └── database_helper.dart          # DB initialization
│   ├── error/
│   │   └── failures.dart                 # Error types
│   └── usecases/
│       └── usecase.dart                  # Base use case
│
├── domain/
│   ├── entities/
│   │   ├── expense.dart                  # Expense entity
│   │   └── category.dart                 # Category entity
│   ├── repositories/
│   │   └── expense_repository.dart       # Repository interface
│   └── usecases/
│       ├── add_expense.dart
│       ├── update_expense.dart
│       ├── delete_expense.dart
│       ├── get_all_expenses.dart
│       ├── get_expenses_by_date_range.dart
│       └── get_expenses_by_category.dart
│
├── data/
│   ├── models/
│   │   └── expense_model.dart            # Data model with mappers
│   ├── datasources/
│   │   └── expense_local_data_source.dart # SQLite operations
│   └── repositories/
│       └── expense_repository_impl.dart   # Repository implementation
│
└── presentation/
    ├── bloc/
    │   ├── expense/
    │   │   ├── expense_bloc.dart
    │   │   ├── expense_event.dart
    │   │   └── expense_state.dart
    │   └── theme/
    │       ├── theme_bloc.dart
    │       ├── theme_event.dart
    │       └── theme_state.dart
    ├── pages/
    │   ├── home/
    │   │   └── home_page.dart
    │   └── expense/
    │       └── add_expense_page.dart
    └── widgets/
        ├── summary_card.dart
        └── expense_card.dart
```

## Dependency Rules

The **Dependency Rule** states that source code dependencies can only point **inward**:

1. **Presentation** → depends on → **Domain**
2. **Data** → depends on → **Domain**
3. **Domain** → depends on → **Nothing** (pure Dart)

This ensures:
- Business logic is independent
- Easy to test
- Easy to maintain
- Easy to scale

## Error Handling

Using `Either` from `dartz` package:

```dart
// Success case
return Right(data);

// Failure case
return Left(DatabaseFailure('Error message'));
```

Benefits:
- Type-safe error handling
- No try-catch in business logic
- Forces error handling at UI level
- Clear error types (DatabaseFailure, CacheFailure, etc.)

## State Management

Using **BLoC** (Business Logic Component):

```dart
// Event → BLoC → State → UI

// 1. User triggers event
context.read<ExpenseBloc>().add(AddExpenseEvent(expense));

// 2. BLoC processes event
// 3. BLoC emits new state
emit(ExpenseLoaded(expenses));

// 4. UI rebuilds based on state
BlocBuilder<ExpenseBloc, ExpenseState>(
  builder: (context, state) {
    if (state is ExpenseLoaded) {
      return ExpenseList(state.expenses);
    }
  },
)
```

## Testing Strategy

### Unit Tests
- Domain layer (use cases, entities)
- Data layer (repositories, data sources)

### Widget Tests
- Individual widgets
- Widget integration

### BLoC Tests
- Event → State transitions
- Business logic flows

### Integration Tests
- End-to-end user flows
- Database operations

## Future Enhancements

1. **Remote Data Source**: Add API integration
2. **Caching Strategy**: Implement cache layer
3. **Offline Support**: Sync when online
4. **Authentication**: Add user management
5. **Multi-platform**: Share business logic across platforms




