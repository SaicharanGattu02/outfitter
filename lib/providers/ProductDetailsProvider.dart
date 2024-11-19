import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';
import 'ProductListProvider.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetails? _productData;
  bool? _isInWishlist;
  bool _isLoading = false;

  // Getters
  ProductDetails? get productData => _productData;
  bool? get isInWishlist => _isInWishlist;
  bool get isLoading => _isLoading;

  // Fetch product details from the repository using the productId
  Future<void> fetchProductDetails(String productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await Userapi.getProductDetails(productId);
      _productData = response?.data;
      _isInWishlist = _productData?.isInWishlist ?? false;
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle wishlist status (to be called when user interacts with the UI)
  void toggleWishlistStatus() {
    if (_productData == null) return;
    bool newStatus = !(isInWishlist ?? false);  // Toggle wishlist status
    // Update local state
    _isInWishlist = newStatus;
    notifyListeners();
  }
}


