import 'package:flutter/material.dart';

class States extends ChangeNotifier {
  int selectedCategory = 0;

  void updateCategory(int selectedCategory) {
    this.selectedCategory = selectedCategory;
    notifyListeners();
  }
}
