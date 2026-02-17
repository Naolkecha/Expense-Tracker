part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const AddExpenseEvent(this.expense);

  @override
  List<Object> get props => [expense];
}

class UpdateExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const UpdateExpenseEvent(this.expense);

  @override
  List<Object> get props => [expense];
}

class DeleteExpenseEvent extends ExpenseEvent {
  final int id;

  const DeleteExpenseEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadExpensesByDateRangeEvent extends ExpenseEvent {
  final DateTime start;
  final DateTime end;

  const LoadExpensesByDateRangeEvent({
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [start, end];
}

class LoadExpensesByCategoryEvent extends ExpenseEvent {}




