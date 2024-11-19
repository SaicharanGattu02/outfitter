import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Model/GetCartListModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';
import 'ShippingDetailsProvider.dart'; // Import your ShippingDetailsProvider

class CartProvider with ChangeNotifier {
  List<CartList> _cartList = [];
  int _cartCount = 0;
  int _cartAmount = 0;
  bool _isLoading = false; // Loading state
  ShippingDetailsProvider shippingDetailsProvider;

  // Constructor
  CartProvider({required this.shippingDetailsProvider});

  // Getters
  List<CartList> get cartList => _cartList;
  int get cartCount => _cartCount;
  int get cartAmount => _cartAmount;
  bool get isLoading => _isLoading; // Expose the loading state

  // Method to fetch cart products
  Future<void> fetchCartProducts() async {
    _isLoading = true; // Set loading state to true before starting the fetch
    notifyListeners(); // Notify listeners that loading has started

    try {
      var response = await Userapi.GetCartList();
      _cartList = response?.data ?? [];
      _cartAmount = response?.totalCartAmount ?? 0;
      _updateCartCount(); // Update cart count after fetching
    } catch (e) {
      throw Exception('Failed to fetch cart list: $e');
    } finally {
      _isLoading = false; // Set loading state to false after fetch completes
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  // Method to add a product to the cart
  Future<String?> addToCartApi(String productID, String quantity, String color,
      String size, sleeve, neck, pleat, placket) async {
    _isLoading =
        true; // Set loading state to true before adding product to cart
    notifyListeners(); // Notify listeners that loading has started

    try {
      var res =
          await Userapi.addCartQuanitity(productID, quantity, color, size, sleeve, neck, pleat, placket);
      if (res != null && res.settings?.success == 1) {
        await fetchCartProducts(); // Re-fetch the cart list after adding

        // Call fetchShippingDetails after adding to cart
        await shippingDetailsProvider
            .fetchShippingDetails(); // Fetch shipping details
        return "Product added to cart successfully!";
      } else {
        return res?.settings?.message;
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    } finally {
      _isLoading = false; // Set loading state to false after the operation
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  // Method to update the quantity of a product in the cart
  Future<void> updateCartApi(String productID, String quantity) async {
    _isLoading = true; // Set loading state to true before updating cart
    notifyListeners(); // Notify listeners that loading has started

    try {
      var res = await Userapi.updateCartQuanitity(productID, quantity);
      if (res != null && res.settings?.success == 1) {
        await fetchCartProducts(); // Re-fetch the cart list after updating

        // Call fetchShippingDetails after adding to cart
        await shippingDetailsProvider
            .fetchShippingDetails(); // Fetch shipping details
      } else {
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      throw Exception('Failed to update cart: $e');
    } finally {
      _isLoading = false; // Set loading state to false after the operation
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  // Update the cart count whenever the cart changes
  void _updateCartCount() {
    _cartCount =
        _cartList.fold(0, (total, item) => total + (item.quantity ?? 0));
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
        notifyListeners(); // Notify listeners to update the UI
      } else {
        // Remove the item if quantity is zero
        _cartList.removeWhere((item) => item.product?.id == productId);
        _updateCartCount(); // Recalculate the cart count
        notifyListeners(); // Notify listeners to update the UI
      }
    } else {
      print("Cart item not found for productId: $productId");
    }
  }
}
