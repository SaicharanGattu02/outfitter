// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';  // For ChangeNotifier
// import 'package:outfitter/Model/WishlistModel.dart';
// import '../Model/AddressListModel.dart';
// import '../Model/CategoriesModel.dart';
// import '../Model/ProductsListModel.dart';
// import '../Model/UserDetailsModel.dart';
// import '../Services/UserApi.dart';
// import 'ProductListProvider.dart';
//
// class UserDetailsProvider with ChangeNotifier {
//   UserDetail? _userdetails;
//
//   UserDetail get userDetails => _userdetails;
//
//   Future<void> fetchUserDetails() async {
//     try {
//       var response = await Userapi.getAdressList();
//       _userdetails = response?.data ?? [];
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Failed to fetch wishlist details: $e');
//     }
//   }
//
//   Future<void> UpdateFromAddressList(String addressID,pincode,mobile,address,address_type) async {
//     try {
//       var res = await Userapi.updateAdress(addressID,pincode,mobile,address,address_type);
//       if (res != null && res.settings?.success == 1) {
//         fetchUserDetails();
//       } else {
//         throw Exception('Failed to remove product from wishlist');
//       }
//     } catch (e) {
//       throw Exception('Failed to remove from wishlist: $e');
//     }
//   }
// }
