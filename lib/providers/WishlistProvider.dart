import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';

class Wishlistprovider with ChangeNotifier {
  List<ProductsList>? _wishlistproducts= [];

  List<ProductsList> get productList => _wishlistproducts??[];

  Future<void> fetchWishList() async{
    try {
      var response = await Userapi.getProductsList("");  // Use the passed productId here
      _wishlistproducts = response?.data??[];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  // Method to add a product to the wishlist
  Future<void> addToWishlist(int productId) async {
    try {
      var res = await Userapi.AddWishList(""); // Call API to add to wishlist
      if (res != null && res.settings?.success == 1) {

      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  // Method to remove a product from the wishlist
  Future<void> removeFromWishlist(int productId) async {
    try {
      var res = await Userapi.RemoveWishList(productId.toString()); // Call API to remove from wishlist
      if (res != null && res.settings?.success == 1) {

        notifyListeners(); // Notify listeners to rebuild UI
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }



}