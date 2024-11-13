import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/CategoriesModel.dart';
import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';

class CategoriesProvider with ChangeNotifier {
  List<Categories>? _categories;

  List<Categories> get categoriesList => _categories??[];

  Future<void> fetchCategoriesList() async{
    try {
      var response = await Userapi.getCategories();  // Use the passed productId here
      _categories = response?.data??[];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

}
