import 'package:flutter/material.dart';
import '../model/products_model.dart';
import '../service/product_service.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsModel? productsModel;
  List<ProductsModel> products = [];
  List<ProductsModel> filteredProducts = [];

  bool isLoading = false;
  String? errorMessage;
  final productsService = ProductsService();

  String selectedCategory = 'All';

  ProductsProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await productsService.fetchProducts();
      filteredProducts = products;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategory(String categoryName) {
    selectedCategory = categoryName;

    if (categoryName == "All") {
      filteredProducts = products;
    } else {
      filteredProducts = products
          .where((product) => product.category?.name == categoryName)
          .toList();
    }

    notifyListeners();
  }

  void searchProducts (String query){
    query = query.toLowerCase();

    if (query.isEmpty){
      filterByCategory(selectedCategory);
    }else{
      filteredProducts = products
          .where((product)=>
      (product.title?.toLowerCase().contains(query)?? false) &&
          (selectedCategory=="All" || product.category?.name == selectedCategory)).toList();
    }
    notifyListeners();
  }
}