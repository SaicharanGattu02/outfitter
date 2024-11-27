import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Model/GetCartListModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';
import 'ShippingDetailsProvider.dart'; // Import your ShippingDetailsProvider

class CartProvider with ChangeNotifier {
  List<CartList> _cartList = [];
  int _cartCount = 0;
  int _cartAmount = 0; // Local total cart amount
  bool _isLoading = false; // Loading state
  // Getters
  List<CartList> get cartList => _cartList;
  int get cartCount => _cartCount;
  int get cartAmount => _cartAmount;
  bool get isLoading => _isLoading;

  // Method to fetch cart products
// Fetch and reload the cart if needed
  void fetchCartProducts({bool forceRefresh = false}) async {
    if (_isLoading && !forceRefresh) return; // Avoid fetching while already loading unless forced

    _isLoading = true; // Set loading state to true before starting the fetch
    notifyListeners(); // Notify listeners that loading has started

    try {
      var response = await Userapi.GetCartList();
      _cartList = response?.data ?? [];
      _cartAmount = response?.totalCartAmount ?? 0; // Make sure we reset the total cart amount
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
    notifyListeners(); // Notify listeners that loading has started
    // Optimistic UI Update: Add product to the local cart
    optimisticAddToCart(productID, int.parse(quantity));

    try {
      var res = await Userapi.addCartQuanitity(productID, quantity, color, size, sleeve, neck, pleat, placket);
      if (res != null && res.settings?.success == 1) {
        // Optionally re-fetch cart or fetch shipping details after adding to cart
        return "Product added to cart successfully!";
      } else {
        // If unsuccessful, roll back the optimistic update
        _rollbackAddToCart(productID);
        return res?.settings?.message;
      }
    } catch (e) {
      // In case of error, rollback the optimistic update
      _rollbackAddToCart(productID);
      throw Exception('Failed to add to cart: $e');
    } finally {
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  // Method to update the quantity of a product in the cart
  Future<void> updateCartApi(String productID, String quantity) async {
    notifyListeners(); // Notify listeners that loading has started

    // Optimistic UI Update: Update quantity in the local cart
    optimisticUpdateCartQuantity(productID, int.parse(quantity));

    try {
      var res = await Userapi.updateCartQuanitity(productID, quantity);
      if (res != null && res.settings?.success == 1) {
      } else {
        // If unsuccessful, roll back the optimistic update
        _rollbackUpdateCartQuantity(productID);
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      // In case of error, rollback the optimistic update
      _rollbackUpdateCartQuantity(productID);
      throw Exception('Failed to update cart: $e');
    } finally {
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  // Optimistic UI Add Method: Update the cart in memory before the server call
  void optimisticAddToCart(String productID, int quantity) {
    var cartItem = _cartList.firstWhere(
          (item) => item.product?.id == productID,
      orElse: () => CartList(id: productID, product: null, quantity: 0),
    );
    if (cartItem.product == null) {
      _cartList.add(CartList(id: productID, product: null, quantity: quantity,amount: cartItem.product?.salePrice)); // Adding the item optimistically
    } else {
      cartItem.quantity = (cartItem.quantity ?? 0) + quantity;
    }
    _updateCartCount(); // Recalculate the cart count
    _recalculateTotalCartAmount(); // Recalculate the total cart amount after adding
    notifyListeners(); // Notify listeners to update the UI immediately
  }

  // Rollback the cart update in case of failure
  void _rollbackAddToCart(String productID) {
    _cartList.removeWhere((item) => item.id == productID); // Remove the item optimistically added
    _updateCartCount(); // Recalculate the cart count
    _recalculateTotalCartAmount(); // Recalculate the total cart amount after rollback
    notifyListeners(); // Notify listeners to update the UI
  }

  // Optimistic Update Method: Update the cart in memory before the server call
  void optimisticUpdateCartQuantity(String productID, int quantity) {
    var cartItem = _cartList.firstWhere(
          (item) => item.product?.id == productID,
      orElse: () => CartList(id: "-1", product: null, quantity: 0),
    );

    if (cartItem.product != null) {
      if (quantity > 0) {
        cartItem.quantity = quantity;
      } else {
        _cartList.removeWhere((item) => item.product?.id == productID); // Remove item if quantity is 0
      }
    }
    _updateCartCount(); // Recalculate the cart count
    _recalculateTotalCartAmount(); // Recalculate the total cart amount after update
    notifyListeners(); // Notify listeners to update the UI immediately
  }

  // Rollback method if the update fails
  void _rollbackUpdateCartQuantity(String productID) {
    fetchCartProducts(forceRefresh: true); // Force fetch the cart list to reset any changes
  }

  void _recalculateTotalCartAmount() {
    // Ensure cart amount is reset before recalculating
    _cartAmount = _cartList.fold<int>(0, (total, item) {
      // Safely cast to int if necessary and perform calculation
      int itemAmount = (item.product?.salePrice ?? 0).toInt(); // Convert to int
      int itemQuantity = (item.quantity ?? 0); // Assuming quantity is already an int
      print("itemAmount:${itemAmount}   itemQuantity:${itemQuantity}   total:${total}");
      return total + (itemAmount * itemQuantity);  // Accumulate total
    });

    notifyListeners(); // Notify listeners to update the UI after recalculation
  }

  // Update the cart count whenever the cart changes
  void _updateCartCount() {
    _cartCount = _cartList.fold(0, (total, item) => total + (item.quantity ?? 0));
    notifyListeners(); // Notify listeners when cart count changes
  }
}
