import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/shared/components/components.dart';
import 'package:expense_tracker/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({super.key, required this.newExpense});

  Function(ExpenseModel expenseModel) newExpense;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  var titleController = TextEditingController();

  var amountController = TextEditingController();

  var category = ExpenseCategory.food;

  var formKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? selectedDate;

  get reset {
    titleController.text = "";
    amountController.text = "";
    selectedDate = DateTime.tryParse("No date selected");
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.maxWidth;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade900,
            leading: IconButton(
                onPressed: () {
                  reset;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text("Flutter Expense Tracker"),
          ),
          body: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16,
                  end: 16,
                  top: 16,
                  bottom: 16 + bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (width > 600)
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    label: Text("Title"),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Title mustn't be empty!!";
                                    }
                                    return null;
                                  },
                                  autocorrect: true,
                                  maxLength: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text("Amount"),
                                    prefixText: "\$ ",
                                  ),
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Amount mustn't be empty!!";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              DropdownButton(
                                  value: category,
                                  items: ExpenseCategory.values
                                      .map((ExpenseCategory category) =>
                                          DropdownMenuItem(
                                            value: category,
                                            child: Text(
                                              category.name.toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (ExpenseCategory? selectedValue) {
                                    setState(() {
                                      category = selectedValue!;
                                    });
                                  }),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(selectedDate == null
                                      ? "No date selected"
                                      : DateFormat.yMd().format(selectedDate!)),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse("2025-06-12"),
                                        ).then((date) {
                                          setState(() {
                                            selectedDate = date!;
                                          });
                                        });
                                      },
                                      icon: const Icon(
                                          Icons.calendar_month_outlined)),
                                  if (selectedDate == null)
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              defaultTextButton(
                                text: "Cancel",
                                onPressed: () {
                                  reset;
                                  Navigator.pop(context);
                                },
                                isUpper: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate() &&
                                        selectedDate != null) {
                                      widget.newExpense(ExpenseModel(
                                          title: titleController.text,
                                          amount: double.tryParse(
                                              amountController.text),
                                          date: selectedDate!,
                                          category: category));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    "Save Expense",
                                    style: TextStyle(fontSize: 16),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    if (width < 600)
                      Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title mustn't be empty!!";
                              }
                              return null;
                            },
                            autocorrect: true,
                            maxLength: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text("Amount"),
                                    prefixText: "\$ ",
                                  ),
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Amount mustn't be empty!!";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(selectedDate == null
                                      ? "No date selected"
                                      : DateFormat.yMd().format(selectedDate!)),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse("2025-06-12"),
                                        ).then((date) {
                                          setState(() {
                                            selectedDate = date!;
                                          });
                                        });
                                      },
                                      icon: const Icon(
                                          Icons.calendar_month_outlined)),
                                  if (selectedDate == null)
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              DropdownButton(
                                  value: category,
                                  items: ExpenseCategory.values
                                      .map((ExpenseCategory category) =>
                                          DropdownMenuItem(
                                            value: category,
                                            child: Text(
                                              category.name.toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (ExpenseCategory? selectedValue) {
                                    setState(() {
                                      category = selectedValue!;
                                    });
                                  }),
                              const Spacer(),
                              defaultTextButton(
                                text: "Cancel",
                                onPressed: () {
                                  reset;
                                  Navigator.pop(context);
                                },
                                isUpper: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate() &&
                                        selectedDate != null) {
                                      widget.newExpense(ExpenseModel(
                                          title: titleController.text,
                                          amount: double.tryParse(
                                              amountController.text),
                                          date: selectedDate!,
                                          category: category));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    "Save Expense",
                                    style: TextStyle(fontSize: 16),
                                  ))
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
