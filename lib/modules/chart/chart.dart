import 'package:expense_tracker/models/chart_model.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/modules/chart/chart_bar.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpenseModel> expenses;

  List<ChartModel> get charts {
    return [
      ChartModel.forCategory(expenses, ExpenseCategory.food),
      ChartModel.forCategory(expenses, ExpenseCategory.leisure),
      ChartModel.forCategory(expenses, ExpenseCategory.travel),
      ChartModel.forCategory(expenses, ExpenseCategory.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final chart in charts) {
      if (chart.totalExpenses > maxTotalExpense) {
        maxTotalExpense = chart.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final chart in charts) // alternative to map()
                  ChartBar(
                    fill: chart.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: charts
                .map(
                  (chart) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[chart.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
