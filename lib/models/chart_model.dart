import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:flutter/foundation.dart';

class ChartModel {
  List<ExpenseModel>? expenses;
  ExpenseCategory? category;

  ChartModel({required this.expenses, required this.category});

  ChartModel.forCategory(List<ExpenseModel>? allExpenses, this.category)
      : expenses = allExpenses!
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses!) {
      sum += expense.amount!;
    }
    return sum;
  }
}
