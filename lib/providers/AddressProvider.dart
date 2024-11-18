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
import 'ShippingDetailsProvider.dart';

class AddressListProvider with ChangeNotifier {
  List<AddressList>? _addresslistproducts = [];
  AddressDetails? _addressDetails;
  String? _selectedAddressId;  // Track selected address ID

  List<AddressList> get addressList => _addresslistproducts ?? [];
  AddressDetails? get addressDetails => _addressDetails;
  String? get selectedAddressId => _selectedAddressId;

  ShippingDetailsProvider shippingDetailsProvider; // Add this as a dependency

  // Constructor
  AddressListProvider({required this.shippingDetailsProvider});

  // Fetch address list from API
  Future<void> fetchAddressList() async {
    try {
      var response = await Userapi.getAdressList();
      _addresslistproducts = response?.data ?? [];

      // Set the selected address ID based on default_address if available
      _setDefaultAddress();

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch address list: $e');
    }
  }

  // Set the default address by checking the address with default_address == true
  void _setDefaultAddress() {
    // Find the first address with default_address == true
    var defaultAddress = _addresslistproducts?.firstWhere(
            (address) => address.default_address == true,
        orElse: () => AddressList()  // Return a default empty AddressList if no default found
    );

    if (defaultAddress != null && defaultAddress.id != null) {
      _selectedAddressId = defaultAddress.id;  // Set the selected address ID
    }
  }

  // Add new address
  Future<int?> AddAddress(pincode, mobile, address, address_type, fullname, alternate) async {
    try {
      var res = await Userapi.addAdress(pincode, mobile, address, address_type, fullname, alternate);
      if (res != null && res.settings?.success == 1) {
        print("AddAddress>>  ${res.settings?.message}");
        fetchAddressList();
        shippingDetailsProvider.fetchShippingDetails();  // Fetch shipping details every time
        return res.settings?.success;
      } else {
        return res?.settings?.success;
      }
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  // Remove address from the list
  Future<void> removFromAddressList(String addressID) async {
    try {
      var res = await Userapi.deleteAdress(addressID);
      if (res != null && res.settings?.success == 1) {
        print('Address removed successfully');
        fetchAddressList();
        // Call fetchShippingDetails after adding to cart
        shippingDetailsProvider.fetchShippingDetails();  // Fetch shipping details every time
      } else {
        throw Exception('Failed to remove address from address list');
      }
    } catch (e) {
      throw Exception('Failed to remove from address list: $e');
    }
  }

  // Mark an address as the default address
  Future<void> defaultFromAddressList(String addressID) async {
    try {
      var res = await Userapi.defaultAdress(addressID);
      if (res != null && res.settings?.success == 1) {
        // Update the address list and re-fetch
        fetchAddressList();
        // Call fetchShippingDetails after adding to cart
        shippingDetailsProvider.fetchShippingDetails();  // Fetch shipping details every time
      } else {
        throw Exception('Failed to set default address');
      }
    } catch (e) {
      throw Exception('Failed to set default address: $e');
    }
  }

  // Update existing address details
  Future<int?> UpdateFromAddressList(String addressID, pincode, mobile, address, address_type, fullname, alternate_mobile) async {
    try {
      var res = await Userapi.updateAdress(addressID, pincode, mobile, address, address_type, fullname, alternate_mobile);
      if (res != null && res.settings?.success == 1) {
        fetchAddressList();
        // Call fetchShippingDetails after adding to cart
        shippingDetailsProvider.fetchShippingDetails();  // Fetch shipping details every time
        return res.settings?.success;
      } else {
        return res?.settings?.success;
      }
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  // Get details of a specific address
  Future<void> getaddressDetails(String addressID) async {
    try {
      var res = await Userapi.getaddressdetails(addressID);
      if (res != null && res.settings?.success == 1) {
        _addressDetails = res.data;
      } else {
        throw Exception('Failed to fetch address details');
      }
    } catch (e) {
      throw Exception('Failed to fetch address details: $e');
    }
  }

  // Update selected address ID when the radio button is changed
  void updateSelectedAddress(String addressID) {
    _selectedAddressId = addressID;
    notifyListeners();  // Notify listeners to update UI
  }
}
