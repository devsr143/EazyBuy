import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/products_model.dart';

class ProductsService{
  static const baseUrl = "http://api.escuelajs.co/api/v1/products";

  Future<List<ProductsModel>> fetchProducts()async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode != 200){
      throw Exception('failed  to load products ${response.statusCode}');

    }
    final List data = jsonDecode(response.body);

    return data.map((e) => ProductsModel.fromJson(e as Map<String,dynamic>)).toList();

  }
}