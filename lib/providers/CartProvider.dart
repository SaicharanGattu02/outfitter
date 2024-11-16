import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Model/GetCartListModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';

class CartProvider with ChangeNotifier {
  List<CartList> _cartList = [];

  List<CartList> get cartList => _cartList;

  Future<void> fetchCartProducts() async {
    try {
      var response = await Userapi.GetCartList();
      _cartList = response?.data ?? [];
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch cartlist: $e');
    }
  }

  Future<String?> addToCartApi(String productID, String quantity,String color,String size) async {
    try {
      var res = await Userapi.addCartQuanitity(productID, quantity,color,size);
      if (res != null && res.settings?.success == 1) {
        fetchCartProducts();
        return "Product added to cart successfully!";// Re-fetch the cart list after adding
      } else {
        return res?.settings?.message;// Re-fetch the cart list after adding
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> updateCartApi(String productID, String quantity) async {
    try {
      var res = await Userapi.updateCartQuanitity(productID, quantity);
      if (res != null && res.settings?.success == 1) {
        fetchCartProducts(); // Re-fetch the cart list after adding
      } else {
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  void updateQuantity(String productId, int quantity) {
    // Find the cart item matching the productId
    var cartItem = _cartList.firstWhere(
          (item) => item.product?.id == productId,
      orElse: () => CartList(id: "-1", product: null, quantity: 0),
    );

    // If the cart item is found and the product is not null
    if (cartItem.product != null) {
      // Update quantity if greater than zero, else remove the item
      if (quantity > 0) {
        cartItem.quantity = quantity;
        notifyListeners();  // Notify listeners to update the UI
      } else {
        // Remove the item if quantity is zero
        _cartList.removeWhere((item) => item.product?.id == productId);
        notifyListeners();  // Notify listeners to update the UI
      }
    } else {
      print("Cart item not found for productId: $productId");
    }
  }
}

