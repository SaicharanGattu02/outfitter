import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';

class ProductListProvider with ChangeNotifier {
  List<ProductsList>? _productlist = [];

  List<ProductsList> get productList => _productlist ?? [];

  Future<void> fetchProductsList(id) async {
    try {
      var response = await Userapi.getProductsList(id);
      _productlist = response?.data ?? [];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

// Method to update wishlist status for a specific product
  void updateProductWishlistStatus(String productId, bool isInWishlist) {
    // Search for the product with the given productId in _productlist
    var product = _productlist?.firstWhere(
          (p) => p.id == productId,
      orElse: () => ProductsList(id: "-1", title: "", image: "", mrp: 0, salePrice: 0, isInWishlist: false), // Use a fallback object
    );

    // Check if a valid product was found by confirming the id is not the fallback -1
    if (product != null && product.id != -1) {
      product.isInWishlist = isInWishlist; // Update the wishlist status
      notifyListeners(); // Notify listeners to rebuild the UI
    }
  }

}