import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  // For ChangeNotifier

import '../Model/ShippingDetailsModel.dart';
import '../Services/UserApi.dart';

class ShippingDetailsProvider with ChangeNotifier {
  ShippingData? _shippingdata;

  ShippingData? get shippingData => _shippingdata;

  Future<void> fetchShippingDetails() async {
    try {
      var response = await Userapi.getShippingDetails();
      _shippingdata = response?.data;  // Assuming response?.data is of type ShippingData
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch shipping details: $e');
    }
  }
}

