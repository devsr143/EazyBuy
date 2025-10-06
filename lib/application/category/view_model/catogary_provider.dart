import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String selectedCategory = 'All';

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }
}
