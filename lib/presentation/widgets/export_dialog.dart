import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../../core/di/injection_container.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/expense.dart';
import '../../domain/usecases/export_expenses_csv.dart';
import '../../domain/usecases/export_expenses_pdf.dart';

class ExportDialog extends StatefulWidget {
  final List<Expense>? expenses;
  final String? format;
  
  const ExportDialog({
    super.key,
    this.expenses,
    this.format,
  });

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    // Auto-export if format is specified
    if (widget.format != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.format == 'csv') {
          _exportCsv(context);
        } else if (widget.format == 'pdf') {
          _exportPdf(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Choose export format:'),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.table_chart),
            title: const Text('Export as CSV'),
            subtitle: const Text('Spreadsheet format'),
            onTap: _isExporting ? null : () => _exportCsv(context),
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text('Export as PDF'),
            subtitle: const Text('Document format'),
            onTap: _isExporting ? null : () => _exportPdf(context),
          ),
          if (_isExporting)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isExporting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Future<void> _exportCsv(BuildContext context) async {
    setState(() => _isExporting = true);
    
    // Store context reference before async operations
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    try {
      // Export CSV
      final exportCsv = sl<ExportExpensesCsv>();
      final result = await exportCsv(NoParams());

      await result.fold(
        (failure) async {
          if (mounted) {
            messenger.showSnackBar(
              SnackBar(
                content: Text('Error: ${failure.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        (csvData) async {
          // Save file to app-specific directory (no permission needed)
          final directory = await getApplicationDocumentsDirectory();
          
          final fileName = 'expenses_${DateTime.now().millisecondsSinceEpoch}.csv';
          final file = File('${directory.path}/$fileName');
          await file.writeAsString(csvData);

          if (mounted) {
            navigator.pop();
            messenger.showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'CSV exported successfully',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
                action: SnackBarAction(
                  label: 'Open',
                  textColor: Colors.white,
                  onPressed: () {
                    OpenFile.open(file.path);
                  },
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Future<void> _exportPdf(BuildContext context) async {
    setState(() => _isExporting = true);
    
    // Store context reference before async operations
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    try {
      // Export PDF
      final exportPdf = sl<ExportExpensesPdf>();
      final result = await exportPdf(NoParams());

      await result.fold(
        (failure) async {
          if (mounted) {
            messenger.showSnackBar(
              SnackBar(
                content: Text('Error: ${failure.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        (pdfBytes) async {
          // Save file to app-specific directory (no permission needed)
          final directory = await getApplicationDocumentsDirectory();
          
          final fileName = 'expenses_${DateTime.now().millisecondsSinceEpoch}.pdf';
          final file = File('${directory.path}/$fileName');
          await file.writeAsBytes(pdfBytes);

          if (mounted) {
            navigator.pop();
            messenger.showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'PDF exported successfully',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
                action: SnackBarAction(
                  label: 'Open',
                  textColor: Colors.white,
                  onPressed: () {
                    OpenFile.open(file.path);
                  },
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}

