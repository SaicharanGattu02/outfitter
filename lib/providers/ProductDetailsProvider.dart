import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';
import 'ProductListProvider.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetails? _productData;
  bool? _isInWishlist;


  ProductDetails? get productData => _productData;
  bool? get isInWishlist => _isInWishlist;

  // Fetch user details from the repository
  // Fetch product details from the repository using the product_id
  Future<void> fetchProductDetails(String productId) async {
    try {
      var response = await Userapi.getProductDetails(productId);  // Use the passed productId here
      _productData = response?.data;
      _isInWishlist=_productData?.isInWishlist??false;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  // Update the wishlist status of the current product
  void toggleWishlistStatus(ProductListProvider productListProvider) {
    if (_productData == null) return;
    bool newStatus = !(isInWishlist ?? false); // Toggle wishlist status
    productListProvider.updateProductWishlistStatus(_productData?.id??"", newStatus);
    // Update local state to reflect the change
    _isInWishlist = newStatus;
    notifyListeners();
  }


}
