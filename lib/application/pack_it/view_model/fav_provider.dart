import 'package:flutter/material.dart';

import '../model/products_model.dart';

class FavoritesProvider with ChangeNotifier {
  final List<ProductsModel> _favorites = [];

  List<ProductsModel> get favorites => _favorites;

  void toggleFavorite(ProductsModel product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(ProductsModel product) {
    return _favorites.contains(product);
  }
}
