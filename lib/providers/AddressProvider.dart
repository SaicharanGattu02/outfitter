import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import 'package:outfitter/Model/WishlistModel.dart';
import '../Model/AddressListModel.dart';
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';
import 'ProductListProvider.dart';

class AddressListProvider with ChangeNotifier {
  List<AddressList>? _addresslistproducts = [];

  List<AddressList> get wishlistProducts => _addresslistproducts ?? [];

  Future<void> fetchAddressList() async {
    try {
      var response = await Userapi.getAdressList();
      _addresslistproducts = response?.data ?? [];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch wishlist details: $e');
    }
  }

  Future<void> AddAddress(pincode,mobile,address,address_type) async {
    try {
      var res = await Userapi.addAdress(pincode,mobile,address,address_type);
      if (res != null && res.settings?.success == 1) {
        fetchAddressList();
      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<void> removFromAddressList(String addressID) async {
    try {
      var res = await Userapi.deleteAdress(addressID);
      if (res != null && res.settings?.success == 1) {
        fetchAddressList();
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  Future<void> UpdateFromAddressList(String addressID,pincode,mobile,address,address_type) async {
    try {
      var res = await Userapi.updateAdress(addressID,pincode,mobile,address,address_type);
      if (res != null && res.settings?.success == 1) {
        fetchAddressList();
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }
}
