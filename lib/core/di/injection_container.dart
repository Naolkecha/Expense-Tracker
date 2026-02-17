import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/datasources/expense_local_data_source.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/delete_expense.dart';
import '../../domain/usecases/get_all_expenses.dart';
import '../../domain/usecases/update_expense.dart';
import '../../domain/usecases/get_expenses_by_date_range.dart';
import '../../domain/usecases/get_expenses_by_category.dart';
import '../../domain/usecases/export_expenses_csv.dart';
import '../../domain/usecases/export_expenses_pdf.dart';
import '../../presentation/bloc/expense/expense_bloc.dart';
import '../../presentation/bloc/theme/theme_bloc.dart';
import '../database/database_helper.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  try {
    print('Initializing database...');
    final database = await DatabaseHelper.initDatabase();
    print('Database initialized successfully');
    sl.registerSingleton<Database>(database);
  } catch (e) {
    print('Database initialization error: $e');
    rethrow;
  }

  // Data Sources
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => AddExpense(sl()));
  sl.registerLazySingleton(() => DeleteExpense(sl()));
  sl.registerLazySingleton(() => GetAllExpenses(sl()));
  sl.registerLazySingleton(() => UpdateExpense(sl()));
  sl.registerLazySingleton(() => GetExpensesByDateRange(sl()));
  sl.registerLazySingleton(() => GetExpensesByCategory(sl()));
  sl.registerLazySingleton(() => ExportExpensesCsv(sl()));
  sl.registerLazySingleton(() => ExportExpensesPdf(sl()));

  // Blocs
  sl.registerFactory(
    () => ExpenseBloc(
      addExpense: sl(),
      deleteExpense: sl(),
      getAllExpenses: sl(),
      updateExpense: sl(),
      getExpensesByDateRange: sl(),
      getExpensesByCategory: sl(),
    ),
  );
  sl.registerFactory(() => ThemeBloc());
}

