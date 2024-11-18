import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';
import 'ProductListProvider.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetails? _productData;
  bool? _isInWishlist;
  bool _isLoading = false;  // Loading state

  // Getters
  ProductDetails? get productData => _productData;
  bool? get isInWishlist => _isInWishlist;
  bool get isLoading => _isLoading;  // Expose the loading state

  // Fetch product details from the repository using the productId
  Future<void> fetchProductDetails(String productId) async {
    _isLoading = true;  // Set isLoading to true before starting the fetch
    notifyListeners();  // Notify listeners that loading has started

    try {
      var response = await Userapi.getProductDetails(productId);  // Fetch product details
      _productData = response?.data;
      _isInWishlist = _productData?.isInWishlist ?? false;
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');  // Handle errors
    } finally {
      _isLoading = false;  // Set isLoading to false after the fetch
      notifyListeners();  // Notify listeners that loading has finished
    }
  }

  // Update the wishlist status of the current product
  void toggleWishlistStatus(ProductListProvider productListProvider) {
    if (_productData == null) return;
    bool newStatus = !(isInWishlist ?? false);  // Toggle wishlist status
    productListProvider.updateProductWishlistStatus(_productData?.id ?? "", newStatus);
    // Update local state to reflect the change
    _isInWishlist = newStatus;
    notifyListeners();
  }
}

