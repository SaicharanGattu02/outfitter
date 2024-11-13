import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetails? _productData;

  ProductDetails? get productData => _productData;

  // Fetch user details from the repository
  // Fetch product details from the repository using the product_id
  Future<void> fetchProductDetails(String productId) async {
    try {
      var response = await Userapi.getProductDetails(productId);  // Use the passed productId here
      _productData = response?.data;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

}
