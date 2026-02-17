import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class DateRangeParams {
  final DateTime start;
  final DateTime end;

  DateRangeParams({required this.start, required this.end});
}

class GetExpensesByDateRange implements UseCase<List<Expense>, DateRangeParams> {
  final ExpenseRepository repository;

  GetExpensesByDateRange(this.repository);

  @override
  Future<Either<Failure, List<Expense>>> call(DateRangeParams params) async {
    return await repository.getExpensesByDateRange(params.start, params.end);
  }
}




