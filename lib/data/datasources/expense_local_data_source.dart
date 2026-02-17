import 'package:sqflite/sqflite.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getAllExpenses();
  Future<int> addExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(int id);
  Future<List<ExpenseModel>> getExpensesByDateRange(DateTime start, DateTime end);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Database database;

  ExpenseLocalDataSourceImpl(this.database);

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'expenses',
        orderBy: 'date DESC',
      );
      return maps.map((map) => ExpenseModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get expenses: $e');
    }
  }

  @override
  Future<int> addExpense(ExpenseModel expense) async {
    try {
      return await database.insert('expenses', expense.toMap());
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await database.update(
        'expenses',
        expense.toMap(),
        where: 'id = ?',
        whereArgs: [expense.id],
      );
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    try {
      await database.delete(
        'expenses',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  @override
  Future<List<ExpenseModel>> getExpensesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'expenses',
        where: 'date BETWEEN ? AND ?',
        whereArgs: [start.toIso8601String(), end.toIso8601String()],
        orderBy: 'date DESC',
      );
      return maps.map((map) => ExpenseModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get expenses by date range: $e');
    }
  }
}




