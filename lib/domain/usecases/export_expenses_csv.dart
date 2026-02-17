import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/expense_repository.dart';

class ExportExpensesCsv implements UseCase<String, NoParams> {
  final ExpenseRepository repository;

  ExportExpensesCsv(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    try {
      final result = await repository.getAllExpenses();
      return result.fold(
        (failure) => Left(failure),
        (expenses) {
          final csvData = StringBuffer();
          csvData.writeln('Date,Title,Category,Amount,Notes');
          
          for (var expense in expenses) {
            csvData.writeln(
              '${expense.date.toIso8601String()},'
              '"${expense.title}",'
              '"${expense.category}",'
              '${expense.amount},'
              '"${expense.notes ?? ''}"',
            );
          }
          
          return Right(csvData.toString());
        },
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}




