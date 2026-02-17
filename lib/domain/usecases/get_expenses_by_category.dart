import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/expense_repository.dart';

class GetExpensesByCategory implements UseCase<Map<String, double>, NoParams> {
  final ExpenseRepository repository;

  GetExpensesByCategory(this.repository);

  @override
  Future<Either<Failure, Map<String, double>>> call(NoParams params) async {
    return await repository.getExpensesByCategory();
  }
}




