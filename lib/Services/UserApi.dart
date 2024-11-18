import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:outfitter/Model/OrderDetailsModel.dart';
import 'package:outfitter/Model/OrdersListModel.dart';
import 'package:outfitter/Model/ProductsListModel.dart';
import 'package:outfitter/Services/otherservices.dart';
import '../Model/AddressListModel.dart';
import '../Model/AdressDeatilsModel.dart';
import '../Model/CategoriesModel.dart';
import '../Model/GetCartListModel.dart';
import '../Model/ProductListSortBy.dart';
import '../Model/ProductsDetailsModel.dart';
import '../Model/RegisterModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Model/ShippingDetailsModel.dart';
import '../Model/VerifyOtpModel.dart';
import '../Model/WishlistModel.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';  // Import this for MediaType


class Userapi {
  static String host = "http://192.168.0.169:8000";

  static Future<RegisterModel?> PostRegister(String fullname, String mail,
      String phone, String password, String gender) async {
    try {
      Map<String, String> data = {
        "full_name": fullname,
        "email": mail,
        "mobile": phone,
        "password": password,
        "gender": gender
      };
      final url = Uri.parse("${host}/auth/register");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data),
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("PostRegister Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> PostOtp(String phone) async {
    try {
      Map<String, String> data = {
        "mobile": phone,
      };
      final url = Uri.parse("${host}/auth/login-otp");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data),
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("PostOtp Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<VerifyOtpModel?> VerifyOtp(String phone, String otp) async {
    try {
      Map<String, String> data = {
        "mobile": phone,
        "otp": otp,
      };
      final url = Uri.parse("${host}/auth/verify-otp");
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data),
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("VerifyOtp Status:${response.body}");
        return VerifyOtpModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<CategoriesModel?> getCategories() async {
    try {
      final url =
          Uri.parse("$host/api/categories"); // Adjusted the endpoint URL
      final headers =
          await getheader1(); // Ensuring headers are fetched asynchronously
      final response = await http.get(
        url,
        headers: headers,
      );
      // Check the response status code
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getCategories response: ${response.body}");

        // Parse the JSON response into a model
        return CategoriesModel.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses (e.g., 401, 404, etc.)
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<ProductsListModel?> getProductsList(String category_id,selectedSort,filterminprice,filtermaxprice) async {
    try {
      final url = Uri.parse("${host}/api/products?category=${category_id}&sort_by=${selectedSort}&min_price=${filterminprice}&max_price=${filtermaxprice}");
      print("url>>${url}");

      final headers = await getheader1();
      final response = await http.get(
        url,
        headers: headers,
      );
      // Check the response status code
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getProductsList response: ${response.body}");
        // Parse the JSON response into a model
        return ProductsListModel.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses (e.g., 401, 404, etc.)
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<ProductsListModel?> getBestSellersList() async {
    try {
      final url = Uri.parse("${host}/api/best-seller-products");
      final headers = await getheader1();
      final response = await http.get(
        url,
        headers: headers,
      );
      // Check the response status code
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getBestSellersList response: ${response.body}");
        // Parse the JSON response into a model
        return ProductsListModel.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses (e.g., 401, 404, etc.)
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<ProductsDetailsModel?> getProductDetails(String? product_id) async {
    try {
      final url = Uri.parse("$host/api/product-details/$product_id");  // Adjusted the endpoint URL
      final headers = await getheader1();  // Ensuring headers are fetched asynchronously
      final response = await http.get(
        url,
        headers: headers,
      );
      // Check the response status code
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getProductDetails response: ${response.body}");

        // Parse the JSON response into a model
        return ProductsDetailsModel.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses (e.g., 401, 404, etc.)
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<RegisterModel?> AddWishList(String product) async {
    print("product>>>${product}");

    try {
      Map<String, String> data = {
        "product": product,
      };
      final url = Uri.parse("${host}/api/wishlists");
      final headers = await getheader2();

      final response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("AddWishList Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> RemoveWishList(String product_id) async {
    print("product_id>>>${product_id}");
    try {

      final url = Uri.parse("${host}/api/update-wishlist/$product_id");
      final headers = await getheader2();
      final response = await http.put(
        url,
        headers: headers,
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("RemoveWishList Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  //
  static Future<RegisterModel?> addCartQuanitity(String productID, String quantity,String color,String size) async {
    try {
      Map<String, String> data = {
        "product": productID,
        "quantity": quantity,
        "color": color,
        "size": size
      };
      final url = Uri.parse("${host}/api/carts");
      final headers = await getheader2();

      final response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("AddCartList Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> updateCartQuanitity(String productID,String quantity) async {
    try {
      Map<String, String> data = {
        "quantity": quantity
      };
      final url = Uri.parse("${host}/api/update-cart/$productID");
      final headers = await getheader2();
      final response = await http.put(
        url,
        headers: headers,
        body: data,
      );
      if (response != null) {
        final jsonResponse = jsonDecode(response.body);
        print("updateCartQuanitity Status:${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<GetCartListModel?> GetCartList() async {
    try {
      final url = Uri.parse("${host}/api/carts");
      final headers = await getheader2();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("GetCartList response: ${response.body}");
        return GetCartListModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null ;
    }
  }

  static Future<WishlistModel?> getWishList() async {
    try {
      final url = Uri.parse("${host}/api/wishlists");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("GetWishList response: ${response.body}");
        return WishlistModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> addAdress(
    String pincode,
    String mobile,
    String address,
    String address_type,
    String fullname,
    String alternate,
  ) async {
    try {
      // Define the form data
      final Map<String, String> formData = {
        'pincode': pincode,
        'mobile': mobile,
        'address': address,
        'address_type': address_type,
        'full_name': fullname,
        'alternate_mobile': alternate,
      };

      print("Formdata:${formData}");
      final url = Uri.parse("${host}/api/address");
      final headers = await getheader1();
      final response = await http.post(url, headers: headers, body: formData);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("addAdress response: ${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> updateAdress(
      String id,
      String pincode,
      String mobile,
      String address,
      String address_type,
      String fullname,
      String alternate,
      ) async {
    try {
      // Define the form data
      final Map<String, String> formData = {
        'pincode': pincode,
        'mobile': mobile,
        'address': address,
        'address_type': address_type,
        'full_name': fullname,
        'alternate_mobile': alternate,
      };
      final url = Uri.parse("${host}/api/update-address/$id");
      final headers = await getheader1();
      final response = await http.put(url, headers: headers,body: formData);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("updateAdress response: ${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> deleteAdress(String id) async {
    try {
      final url = Uri.parse("${host}/api/update-address/$id");
      final headers = await getheader1();
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("deleteAdress response: ${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> defaultAdress(String id) async {
    try {
      final url = Uri.parse("${host}/api/default-address/$id");
      final headers = await getheader1();
      final response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("defaultAdress response: ${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<AdressDeatilsModel?> getaddressdetails(String id) async {
    try {
      final url = Uri.parse("${host}/api/address-details/$id");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getaddress response: ${response.body}");
        return AdressDeatilsModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<AddressListModel?> getAdressList() async {
    try {
      final url = Uri.parse("${host}/api/address");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getAdressList response: ${response.body}");
        return AddressListModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<UserDetailsModel?> getUserdetsils() async {
    try {
      final url = Uri.parse("${host}/auth/user-detail");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getUserdetsils response: ${response.body}");
        return UserDetailsModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> updateprofile(
      String id,
      String pincode,
      String mobile,
      String address,
      String address_type,
      ) async {
    try {
      // Define the form data
      final Map<String, String> formData = {
        'pincode': pincode,
        'mobile': mobile,
        'address': address,
        'address_type': address_type
      };
      final url = Uri.parse("${host}/api/update-address/$id");
      final headers = await getheader1();
      final response = await http.put(url, headers: headers,body: formData);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("updateAdress response: ${response.body}");
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }



  static Future<RegisterModel?> updateProfile(
      String fullname,
      String mobile,
      String email,
      File? image,  // Accept a file for the image

      ) async {
    String? mimeType;

    // Check if the image is a valid image file
    if (image != null) {
      mimeType = lookupMimeType(image.path);  // Get MIME type for the image
      if (mimeType == null || !mimeType.startsWith('image/')) {
        print('Selected file is not a valid image.');
        return null;
      }
    }

    try {
      // Prepare the URL for the update request
      final url = Uri.parse("${host}/auth/user-detail");

      // Create a MultipartRequest for a multipart form upload
      final request = http.MultipartRequest('PUT', url);

      // Add headers (use your token and necessary headers here)
      final headers = await getheader1(); // Assuming you have a function to get headers
      request.headers.addAll(headers);

      // Add fields (name, mobile, email)
      request.fields['full_name'] = fullname;
      request.fields['mobile'] = mobile;
      request.fields['email'] = email;

      // If an image is provided, add it to the request as a file
      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',  // The name of the file field in your API
            image.path,
            contentType: MediaType.parse(mimeType!),  // Ensure mime type is non-null
          ),
        );
      }

      print("Req filelds:${request.fields}");

      // Send the request
      final response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseBody);
        print("updateProfile response: ${responseBody}");
        return RegisterModel.fromJson(jsonResponse);  // Assuming RegisterModel parses the response
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }




  static Future<ShippingDetailsModel?> getShippingDetails() async {
    try {
      final url = Uri.parse("${host}/api/shipping_details");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getShippingDetails response: ${response.body}");
        return ShippingDetailsModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

  static Future<RegisterModel?> placeOrder(
      int order_value,
      String address,
      List<String> items, // Changed to accept a list of items
      ) async {
    // Set the URL of your API
    final url = Uri.parse('${host}/api/orders');

    // Get headers dynamically
    final headers = await getheader2();

    // Create a multipart request
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['order_value'] = order_value.toString()
      ..fields['payment_method'] = 'Cash on delivery'
      ..fields['address'] = address;

    // Use this approach to handle multiple collaborators
    request.fields.addAll({
      for (int i = 0; i < items.length; i++) 'items[$i]': items[i],
    });

    try {
      // Send the request
      print("Request Fields: ${request.fields}");
      var response = await request.send();

      // Check for a successful response
      if (response.statusCode == 200) {
        print('Order placed successfully!');
        final responseData = await response.stream.bytesToString();

        // Decode the JSON response
        final jsonResponse = jsonDecode(responseData);
        print("placeOrder response: $jsonResponse");

        // Assuming RegisterModel has a fromJson constructor
        return RegisterModel.fromJson(jsonResponse);
      } else {
        print('Failed to place order. Status code: ${response.statusCode}');
        final responseData = await response.stream.bytesToString();
        print('Response: $responseData');
      }
    } catch (e) {
      print('Error: $e');
    }

    return null; // Return null if there's an error
  }

  static Future<OrdersListModel?> getOrdersList() async {
    try {
      final url = Uri.parse("${host}/api/orders");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getOrdersList response: ${response.body}");
        return OrdersListModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }


  static Future<OrderDetailsModel?> getOrderDetails(String id) async {
    try {
      final url = Uri.parse("${host}/api/order-details/$id");
      final headers = await getheader1();
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("getOrderDetails response: ${response.body}");
        return OrderDetailsModel.fromJson(jsonResponse);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any exceptions (e.g., network failure, JSON parsing error)
      print("Error occurred: $e");
      return null;
    }
  }

 static Future<ProductsListModel?> fetchProducts(String query) async {
   try {
    final url = Uri.parse('${host}/api/search-products?q=$query');
    final headers = await getheader1();
    final response = await http.get(url, headers:headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("getOrdersList response: ${response.body}");
      return ProductsListModel.fromJson(jsonResponse);
    } else {
      print("Request failed with status: ${response.statusCode}");
      return null;
    }
   } catch (e) {
     // Catch any exceptions (e.g., network failure, JSON parsing error)
     print("Error occurred: $e");
     return null;
   }
  }

  static Future<RegisterModel?> SubmitReviewApi(String page_source, String rating, String review) async {
      try {
        // Prepare the data
        Map<String, String> data = {
          "rating": rating,
          "details": review,
          "page_source": page_source,
        };
        print("SubmitReviewApi: ${data}");

        final url = Uri.parse("$host/api/create_review");
        final headers =
        await getheader2(); // Assuming this fetches headers with Authorization

        // Send the POST request
        final response = await http.post(
          url,
          headers: headers,
          body: data, // Use data directly for x-www-form-urlencoded
        );
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          print("SubmitReview Status: ${response.body}");
          return RegisterModel.fromJson(jsonResponse);
        } else {
          print("Error: ${response.statusCode} ${response.body}");
          return null;
        }
      } catch (e) {
        print("Error occurred: $e");
        return null;
      }
  }




}
