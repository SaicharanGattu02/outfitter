import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';

class ProductListProvider with ChangeNotifier {
  List<ProductsList>? _productlist = [];
  List<ProductsList> get productList => _productlist ?? [];

  List<ProductsList> _bestsellerproductlist = [];
  List<ProductsList> get bestsellerList => _bestsellerproductlist ?? [];

  bool _isLoading = false;  // Loading state
  bool get isLoading => _isLoading;  // Expose isLoading for UI updates

  // Fetch Products List
  Future<void> fetchProductsList(id, selectedSort, filterminprice, filtermaxprice) async {
    _isLoading = true;  // Set loading state to true before fetching data
    notifyListeners();  // Notify listeners that loading has started

    try {
      var response = await Userapi.getProductsList(id, selectedSort, filterminprice, filtermaxprice);
      _productlist = response?.data ?? [];
      print("fetchProductsList>>${_productlist}");
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    } finally {
      _isLoading = false;  // Set loading state to false after fetch completes
      notifyListeners();  // Notify listeners that loading has finished
    }
  }

  // Fetch Bestsellers List
  Future<void> fetchBestSellersList() async {
    _isLoading = true;  // Set loading state to true before fetching data
    notifyListeners();  // Notify listeners that loading has started

    try {
      final res = await Userapi.getBestSellersList();
      if (res != null) {
        if (res.settings?.success == 1) {
          _bestsellerproductlist = res.data ?? [];
        }
      }
    } catch (e) {
      throw Exception('Failed to fetch list: $e');
    } finally {
      _isLoading = false;  // Set loading state to false after fetch completes
      notifyListeners();  // Notify listeners that loading has finished
    }
  }

  // Update wishlist status for a specific product in the product list
  void updateProductWishlistStatus(String productId, bool isInWishlist) {
    // Update wishlist status for product in _productlist
    var product = _productlist?.firstWhere(
          (p) => p.id == productId,
      orElse: () => ProductsList(id: "-1", title: "", image: "", mrp: 0, salePrice: 0, isInWishlist: false),
    );

    if (product != null && product.id != "-1") {
      product.isInWishlist = isInWishlist;
      notifyListeners();
    }
  }

  // Update wishlist status for a specific product in the bestseller list
  void updateBestsellerWishlistStatus(String productId, bool isInWishlist) {
    // Update wishlist status for product in _bestsellerproductlist
    var product = _bestsellerproductlist.firstWhere(
          (p) => p.id == productId,
      orElse: () => ProductsList(id: "-1", title: "", image: "", mrp: 0, salePrice: 0, isInWishlist: false),
    );

    if (product.id != "-1") {
      product.isInWishlist = isInWishlist;
      notifyListeners();
    }
  }
}

