import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/expense.dart';

class BarChartWidget extends StatelessWidget {
  final List<Expense> expenses;
  final String period;

  const BarChartWidget({
    super.key,
    required this.expenses,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final data = _prepareChartData();
    final maxY = data.values.isEmpty ? 100.0 : data.values.reduce((a, b) => a > b ? a : b) * 1.2;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final value = rod.toY;
              return BarTooltipItem(
                '\$${value.toStringAsFixed(2)}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final labels = data.keys.toList();
                if (value.toInt() >= 0 && value.toInt() < labels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[value.toInt()],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '\$${value.toInt()}',
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 5,
        ),
        borderData: FlBorderData(show: false),
        barGroups: data.entries.map((entry) {
          final index = data.keys.toList().indexOf(entry.key);
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                color: Theme.of(context).colorScheme.primary,
                width: 20,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Map<String, double> _prepareChartData() {
    final Map<String, double> chartData = {};

    switch (period) {
      case 'Daily':
        // Last 7 days
        for (int i = 6; i >= 0; i--) {
          final date = DateTime.now().subtract(Duration(days: i));
          final key = DateFormat('EEE').format(date);
          chartData[key] = 0;
        }
        for (var expense in expenses) {
          final key = DateFormat('EEE').format(expense.date);
          if (chartData.containsKey(key)) {
            chartData[key] = (chartData[key] ?? 0) + expense.amount;
          }
        }
        break;

      case 'Weekly':
        // Last 4 weeks
        for (int i = 3; i >= 0; i--) {
          final key = 'W${4 - i}';
          chartData[key] = 0;
        }
        for (var expense in expenses) {
          final now = DateTime.now();
          final weeksDiff = ((now.difference(expense.date).inDays) / 7).floor();
          if (weeksDiff >= 0 && weeksDiff < 4) {
            final key = 'W${4 - weeksDiff}';
            chartData[key] = (chartData[key] ?? 0) + expense.amount;
          }
        }
        break;

      case 'Monthly':
        // Last 6 months
        for (int i = 5; i >= 0; i--) {
          final date = DateTime(
            DateTime.now().year,
            DateTime.now().month - i,
            1,
          );
          final key = DateFormat('MMM').format(date);
          chartData[key] = 0;
        }
        for (var expense in expenses) {
          final key = DateFormat('MMM').format(expense.date);
          if (chartData.containsKey(key)) {
            chartData[key] = (chartData[key] ?? 0) + expense.amount;
          }
        }
        break;
    }

    return chartData;
  }
}

