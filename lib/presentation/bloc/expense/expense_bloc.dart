import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/usecases/add_expense.dart';
import '../../../domain/usecases/delete_expense.dart';
import '../../../domain/usecases/get_all_expenses.dart';
import '../../../domain/usecases/update_expense.dart';
import '../../../domain/usecases/get_expenses_by_date_range.dart';
import '../../../domain/usecases/get_expenses_by_category.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final AddExpense addExpense;
  final DeleteExpense deleteExpense;
  final GetAllExpenses getAllExpenses;
  final UpdateExpense updateExpense;
  final GetExpensesByDateRange getExpensesByDateRange;
  final GetExpensesByCategory getExpensesByCategory;

  ExpenseBloc({
    required this.addExpense,
    required this.deleteExpense,
    required this.getAllExpenses,
    required this.updateExpense,
    required this.getExpensesByDateRange,
    required this.getExpensesByCategory,
  }) : super(ExpenseInitial()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
    on<AddExpenseEvent>(_onAddExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
    on<LoadExpensesByDateRangeEvent>(_onLoadExpensesByDateRange);
    on<LoadExpensesByCategoryEvent>(_onLoadExpensesByCategory);
  }

  Future<void> _onLoadExpenses(
    LoadExpensesEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await getAllExpenses(NoParams());
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (expenses) => emit(ExpenseLoaded(expenses)),
    );
  }

  Future<void> _onAddExpense(
    AddExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final result = await addExpense(event.expense);
    await result.fold(
      (failure) async => emit(ExpenseError(failure.message)),
      (id) async {
        emit(const ExpenseOperationSuccess('Expense added successfully'));
        add(LoadExpensesEvent());
      },
    );
  }

  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final result = await updateExpense(event.expense);
    await result.fold(
      (failure) async => emit(ExpenseError(failure.message)),
      (_) async {
        emit(const ExpenseOperationSuccess('Expense updated successfully'));
        add(LoadExpensesEvent());
      },
    );
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final result = await deleteExpense(event.id);
    await result.fold(
      (failure) async => emit(ExpenseError(failure.message)),
      (_) async {
        emit(const ExpenseOperationSuccess('Expense deleted successfully'));
        add(LoadExpensesEvent());
      },
    );
  }

  Future<void> _onLoadExpensesByDateRange(
    LoadExpensesByDateRangeEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await getExpensesByDateRange(
      DateRangeParams(start: event.start, end: event.end),
    );
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (expenses) => emit(ExpenseLoaded(expenses)),
    );
  }

  Future<void> _onLoadExpensesByCategory(
    LoadExpensesByCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await getExpensesByCategory(NoParams());
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (categoryTotals) => emit(ExpenseCategoryLoaded(categoryTotals)),
    );
  }
}




