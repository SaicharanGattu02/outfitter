import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';

class ProductListProvider with ChangeNotifier {
  List<ProductsList>? _productlist = [];

  List<ProductsList> get productList => _productlist??[];

  Future<void> fetchProductsList() async{
    try {
      var response = await Userapi.getProductsList("");
      _productlist = response?.data??[];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }
}