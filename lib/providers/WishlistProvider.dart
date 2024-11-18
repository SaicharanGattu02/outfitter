import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import 'package:outfitter/Model/WishlistModel.dart';
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';
import 'ProductListProvider.dart';

class WishlistProvider with ChangeNotifier {
  List<Wishlist>? _wishlistproducts = [];

  List<Wishlist> get wishlistProducts => _wishlistproducts ?? [];

  ProductListProvider productListProvider;  // Remove 'final' to allow updating

  WishlistProvider(this.productListProvider);

  // Method to update ProductListProvider reference
  void updateProductListProvider(ProductListProvider newProvider) {
    productListProvider = newProvider;
  }

  Future<int?> fetchWishList() async {
    try {
      var response = await Userapi.getWishList();
      if(response?.settings?.success==1){
        _wishlistproducts = response?.data ?? [];
        notifyListeners();
        return response?.settings?.success;
      }else{
        return response?.settings?.success;
      }
    } catch (e) {
      throw Exception('Failed to fetch wishlist details: $e');
    }
  }

  Future<void> addToWishlist(String productId) async {
    try {
      var res = await Userapi.AddWishList(productId.toString());
      if (res != null && res.settings?.success == 1) {
        fetchWishList();
        productListProvider.updateProductWishlistStatus(productId, true);
        productListProvider.updateBestsellerWishlistStatus(productId, true);
      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      var res = await Userapi.RemoveWishList(productId.toString());
      if (res != null && res.settings?.success == 1) {
        fetchWishList();
        productListProvider.updateProductWishlistStatus(productId, false);
        productListProvider.updateBestsellerWishlistStatus(productId, false);
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }
}
