import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Model/GetCartListModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';
import 'ShippingDetailsProvider.dart';  // Import your ShippingDetailsProvider

class CartProvider with ChangeNotifier {
  List<CartList> _cartList = [];
  int _cartCount = 0;
  ShippingDetailsProvider shippingDetailsProvider; // Add this as a dependency

  // Constructor
  CartProvider({required this.shippingDetailsProvider});

  // Getter for cart list
  List<CartList> get cartList => _cartList;

  // Getter for cart count
  int get cartCount => _cartCount;

  // Method to fetch cart products
  Future<void> fetchCartProducts() async {
    try {
      var response = await Userapi.GetCartList();
      _cartList = response?.data ?? [];
      _updateCartCount(); // Update the cart count after fetching
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch cart list: $e');
    }
  }

  // Method to add a product to the cart
  Future<String?> addToCartApi(String productID, String quantity, String color, String size) async {
    try {
      var res = await Userapi.addCartQuanitity(productID, quantity, color, size);
      if (res != null && res.settings?.success == 1) {
        fetchCartProducts();  // Re-fetch the cart list after adding

        // Call fetchShippingDetails after adding to cart
        shippingDetailsProvider.fetchShippingDetails();  // Fetch shipping details every time
        return "Product added to cart successfully!";
      } else {
        return res?.settings?.message;
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  // Method to update the quantity of a product in the cart
  Future<void> updateCartApi(String productID, String quantity) async {
    try {
      var res = await Userapi.updateCartQuanitity(productID, quantity);
      if (res != null && res.settings?.success == 1) {
        fetchCartProducts();  // Re-fetch the cart list after updating

        // Call fetchShippingDetails after adding to cart
        shippingDetailsProvider.fetchShippingDetails();  // Fetch shipping details every time
      } else {
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      throw Exception('Failed to update cart: $e');
    }
  }

  // Update the cart count whenever the cart changes
  void _updateCartCount() {
    _cartCount = _cartList.fold(0, (total, item) => total + (item.quantity ?? 0));
    notifyListeners(); // Notify listeners when cart count changes
  }

  // Method to update the quantity of an item directly in the cart
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
        _updateCartCount(); // Recalculate the cart count
        notifyListeners();  // Notify listeners to update the UI
      } else {
        // Remove the item if quantity is zero
        _cartList.removeWhere((item) => item.product?.id == productId);
        _updateCartCount(); // Recalculate the cart count
        notifyListeners();  // Notify listeners to update the UI
      }
    } else {
      print("Cart item not found for productId: $productId");
    }
  }
}
