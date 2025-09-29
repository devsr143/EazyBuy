import 'package:flutter/material.dart';
import 'package:pack_bags/pack_it/model/products_model.dart';

class CartProvider with ChangeNotifier {
  final Map<ProductsModel, int> _cartItems = {};

  Map<ProductsModel, int> get cartItems => _cartItems;

  void addToCart(ProductsModel product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(ProductsModel product) {
    if (_cartItems.containsKey(product)) {
      _cartItems.remove(product);
      notifyListeners();
    }
  }

  void increaseQuantity(ProductsModel product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductsModel product) {
    if (_cartItems.containsKey(product)) {
      if (_cartItems[product]! > 1) {
        _cartItems[product] = _cartItems[product]! - 1;
      } else {
        _cartItems.remove(product);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get itemCount => _cartItems.length;

  double get totalPrice {
    double total = 0;
    _cartItems.forEach((product, quantity) {
      total += (product.price?.toDouble() ?? 0) * quantity;
    });
    return total;
  }
}
