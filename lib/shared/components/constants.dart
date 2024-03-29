import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuId = Uuid();

enum ExpenseCategory { food, travel, leisure, work }

const categoryIcons = {
  ExpenseCategory.food: Icons.lunch_dining_outlined,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.leisure: Icons.movie,
  ExpenseCategory.work: Icons.work,
};
