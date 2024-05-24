import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/modules/chart/chart.dart';
import 'package:expense_tracker/modules/expense.dart';
import 'package:expense_tracker/shared/components/components.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleController = TextEditingController();

  var amountController = TextEditingController();

  var category = ExpenseCategory.food;

  var formKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  String? selectedDate;

  List<ExpenseModel> expenses = [
    ExpenseModel(
        title: "Flutter Course",
        amount: 19.9999,
        date: DateTime.now(),
        category: ExpenseCategory.work),
    ExpenseModel(
        title: "Cinema",
        amount: 15.6988,
        date: DateTime.now(),
        category: ExpenseCategory.leisure),
    ExpenseModel(
        title: "Eating",
        amount: 15.6543,
        date: DateTime.now(),
        category: ExpenseCategory.food),
  ];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  addExpense(ExpenseModel newExpense) {
    setState(() {
      expenses.add(newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: Text(
          "Expense Tracker",
          style: TextStyle(
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConditionalBuilder(
          condition: width < 600,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (expenses.isNotEmpty) Chart(expenses: expenses),
              const SizedBox(
                height: 10,
              ),
              ConditionalBuilder(
                condition: expenses.isNotEmpty,
                builder: (context) => Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        defaultItem(context, expenses[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: expenses.length,
                  ),
                ),
                fallback: (context) => defaultTestScreen(
                    text: "There is no expenses try to add.."),
              ),
            ],
          ),
          fallback: (context) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (expenses.isNotEmpty)
                Expanded(child: Chart(expenses: expenses)),
              const SizedBox(
                width: 10,
              ),
              ConditionalBuilder(
                condition: expenses.isNotEmpty,
                builder: (context) => Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        defaultItem(context, expenses[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: expenses.length,
                  ),
                ),
                fallback: (context) => defaultTestScreen(
                    text: "There is no expenses try to add.."),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(
              context,
              ExpenseScreen(
                newExpense: addExpense,
              ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget defaultItem(context, ExpenseModel expense) => Dismissible(
        key: Key(expense.id!),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onDismissed: (direction) {
          setState(() {
            expenses.remove(expense);
          });
        },
        child: Card(
          shape: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(20)),
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "\$${expense.amount!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      expense.formatDate!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
