import 'package:expense_tracker/shared/components/constants.dart';
import 'package:intl/intl.dart';

class ExpenseModel {
  String? id;
  String? title;
  double? amount;
  DateTime date;
  ExpenseCategory? category;

  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuId.v4();

  get formatDate => DateFormat.yMd().format(date);
}
