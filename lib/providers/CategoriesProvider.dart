import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/CategoriesModel.dart';
import '../Model/ProductsDetailsModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';

class CategoriesProvider with ChangeNotifier {
  List<Categories>? _categories;
  List<ProductsList> _productlist = [];

  List<Categories> get categoriesList => _categories??[];
  List<ProductsList> get bestsellerList => _productlist??[];

  Future<void> fetchCategoriesList() async{
    try {
      var response = await Userapi.getCategories();  // Use the passed productId here
      _categories = response?.data??[];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  Future<void> fetchBestSellersList() async {
    try {
      final res = await Userapi.getBestSellersList();
      if (res != null) {
          if (res.settings?.success == 1) {
            _productlist = res.data ?? [];
            notifyListeners();
          }
      }
    } catch (e) {
      throw Exception('Failed to fetch list: $e');
    }
  }

}
