import 'package:dartz/dartz.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/expense_repository.dart';

class ExportExpensesPdf implements UseCase<List<int>, NoParams> {
  final ExpenseRepository repository;

  ExportExpensesPdf(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    try {
      final result = await repository.getAllExpenses();
      return await result.fold(
        (failure) async => Left(failure),
        (expenses) async {
          final pdf = pw.Document();
          final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
          final dateFormat = DateFormat('MMM dd, yyyy');
          
          final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);
          
          // Group by category
          final categoryTotals = <String, double>{};
          for (var expense in expenses) {
            categoryTotals[expense.category] =
                (categoryTotals[expense.category] ?? 0) + expense.amount;
          }

          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
              build: (context) => [
                // Header
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    'Expense Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                
                // Summary
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey300,
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Summary',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total Expenses:'),
                          pw.Text(
                            currencyFormat.format(total),
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total Transactions:'),
                          pw.Text(
                            '${expenses.length}',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
                
                // Category Breakdown
                pw.Text(
                  'Category Breakdown',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.TableHelper.fromTextArray(
                  headers: ['Category', 'Amount', 'Percentage'],
                  data: categoryTotals.entries.map((entry) {
                    final percentage = (entry.value / total * 100).toStringAsFixed(1);
                    return [
                      entry.key,
                      currencyFormat.format(entry.value),
                      '$percentage%',
                    ];
                  }).toList(),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  cellAlignment: pw.Alignment.centerLeft,
                ),
                pw.SizedBox(height: 20),
                
                // Expense List
                pw.Text(
                  'All Expenses',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.TableHelper.fromTextArray(
                  headers: ['Date', 'Title', 'Category', 'Amount'],
                  data: expenses.map((expense) {
                    return [
                      dateFormat.format(expense.date),
                      expense.title,
                      expense.category,
                      currencyFormat.format(expense.amount),
                    ];
                  }).toList(),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  cellAlignment: pw.Alignment.centerLeft,
                ),
              ],
            ),
          );

          return Right(await pdf.save());
        },
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}

