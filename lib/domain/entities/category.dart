import 'package:flutter/material.dart';

class ExpenseCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class Categories {
  static const List<ExpenseCategory> all = [
    ExpenseCategory(
      name: 'Food',
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    ExpenseCategory(
      name: 'Transport',
      icon: Icons.directions_car,
      color: Colors.blue,
    ),
    ExpenseCategory(
      name: 'Shopping',
      icon: Icons.shopping_bag,
      color: Colors.purple,
    ),
    ExpenseCategory(
      name: 'Entertainment',
      icon: Icons.movie,
      color: Colors.pink,
    ),
    ExpenseCategory(
      name: 'Bills',
      icon: Icons.receipt_long,
      color: Colors.red,
    ),
    ExpenseCategory(
      name: 'Health',
      icon: Icons.local_hospital,
      color: Colors.green,
    ),
    ExpenseCategory(
      name: 'Education',
      icon: Icons.school,
      color: Colors.indigo,
    ),
    ExpenseCategory(
      name: 'Others',
      icon: Icons.more_horiz,
      color: Colors.grey,
    ),
  ];

  static ExpenseCategory getCategory(String name) {
    return all.firstWhere(
      (category) => category.name == name,
      orElse: () => all.last,
    );
  }
}




