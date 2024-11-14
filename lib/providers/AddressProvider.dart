import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier
import 'package:outfitter/Model/WishlistModel.dart';
import '../Model/AddressListModel.dart';
import '../Model/AdressDeatilsModel.dart';
import '../Model/CategoriesModel.dart';
import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';
import 'ProductListProvider.dart';

class AddressListProvider with ChangeNotifier {
  List<AddressList>? _addresslistproducts = [];
  AddressDetails? _addressDetails;

  List<AddressList> get addressList => _addresslistproducts ?? [];
  AddressDetails? get addressDetails => _addressDetails;

  Future<void> fetchAddressList() async {
    try {
      var response = await Userapi.getAdressList();
      _addresslistproducts = response?.data ?? [];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch wishlist details: $e');
    }
  }

  Future<int?> AddAddress(pincode,mobile,address,address_type,fullname,alternate) async {
    try {
      var res = await Userapi.addAdress(pincode,mobile,address,address_type,fullname,alternate);
      if (res != null && res.settings?.success == 1) {
        print("AddAddress>>  ${res.settings?.message}");
        fetchAddressList();
        return res.settings?.success;
      } else {
        return res?.settings?.success;
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<void> removFromAddressList(String addressID) async {
    try {
      var res = await Userapi.deleteAdress(addressID);
      if (res != null && res.settings?.success == 1) {
        print('remove successfully');
        fetchAddressList();
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  Future<int?> UpdateFromAddressList(String addressID,pincode,mobile,address,address_type,fullname,alternate_mobile) async {
    try {
      var res = await Userapi.updateAdress(addressID,pincode,mobile,address,address_type,fullname,alternate_mobile);
      if (res != null && res.settings?.success == 1) {
        fetchAddressList();
        return res.settings?.success;
      } else {
        return res?.settings?.success;
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
}

  Future<void> getaddressDetails(String addressID) async {
    try {
      var res = await Userapi.getaddressdetails(addressID);
      if (res != null && res.settings?.success == 1) {
        _addressDetails=res.data;
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }



}