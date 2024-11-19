import 'ProductsDetailsModel.dart';

class GetCartListModel {
  List<CartList>? data;
  dynamic totalCartAmount;
  Settings? settings;

  GetCartListModel({this.data, this.totalCartAmount, this.settings});

  GetCartListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CartList>[];
      json['data'].forEach((v) {
        data!.add(new CartList.fromJson(v));
      });
    }
    totalCartAmount = json['total_cart_amount'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_cart_amount'] = this.totalCartAmount;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class CartList {
  String id;
  Product? product;
  int quantity;
  dynamic amount;
  List<Sleeve> sleeve;
  List<Neck> neck;
  List<Placket> placket;
  List<Pleat> pleat;
  String size;
  String color;

  CartList({
    this.id = "", // default to empty string
    this.product,
    this.quantity = 0, // default to 0
    this.amount = 0, // default to 0
    List<Sleeve>? sleeve,
    List<Neck>? neck,
    List<Placket>? placket,
    List<Pleat>? pleat,
    this.size = "", // default to empty string
    this.color = "", // default to empty string
  })  : sleeve = sleeve ?? [],
        neck = neck ?? [],
        placket = placket ?? [],
        pleat = pleat ?? [];

  CartList.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        product = json['product'] != null ? Product.fromJson(json['product']) : null,
        quantity = json['quantity'] ?? 0,
        amount = json['amount'] ?? 0,
  // Ensure these fields are either null or valid lists
        sleeve = _parseList<Sleeve>(json['sleeve']),
        neck = _parseList<Neck>(json['neck']),
        placket = _parseList<Placket>(json['placket']),
        pleat = _parseList<Pleat>(json['pleat']),
        size = json['size'] ?? "",
        color = json['color'] ?? "";

  // A helper function to safely parse lists, ensuring the value is either null or a valid list.
  static List<T> _parseList<T>(dynamic value) {
    if (value == null) {
      return [];
    }
    if (value is List) {
      return value.map((item) => _fromJson<T>(item)).toList();
    }
    return [];
  }

  // A helper function to handle parsing of items from JSON for different types
  static T _fromJson<T>(dynamic json) {
    if (T == Sleeve) {
      return Sleeve.fromJson(json) as T;
    } else if (T == Neck) {
      return Neck.fromJson(json) as T;
    } else if (T == Placket) {
      return Placket.fromJson(json) as T;
    } else if (T == Pleat) {
      return Pleat.fromJson(json) as T;
    }
    throw Exception('Unknown type: $T');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['sleeve'] = sleeve.map((item) => item.toJson()).toList();
    data['neck'] = neck.map((item) => item.toJson()).toList();
    data['placket'] = placket.map((item) => item.toJson()).toList();
    data['pleat'] = pleat.map((item) => item.toJson()).toList();
    data['size'] = size;
    data['color'] = color;
    return data;
  }
}


class Product {
  String? id;
  String? title;
  String? category;
  bool? isBestSeller;
  String? brand;
  String? postedBy;
  int? mrp;
  int? salePrice;
  bool? isInWishlist;
  String? image;
  dynamic rating;

  Product(
      {this.id,
        this.title,
        this.category,
        this.isBestSeller,
        this.brand,
        this.postedBy,
        this.mrp,
        this.salePrice,
        this.isInWishlist,
        this.image,
        this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    isBestSeller = json['is_best_seller'];
    brand = json['brand'];
    postedBy = json['posted_by'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    isInWishlist = json['is_in_wishlist'];
    image = json['image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['is_best_seller'] = this.isBestSeller;
    data['brand'] = this.brand;
    data['posted_by'] = this.postedBy;
    data['mrp'] = this.mrp;
    data['sale_price'] = this.salePrice;
    data['is_in_wishlist'] = this.isInWishlist;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}

class Settings {
  int? success;
  String? message;
  int? status;
  int? page;
  bool? nextPage;
  bool? prevPage;

  Settings(
      {this.success,
        this.message,
        this.status,
        this.page,
        this.nextPage,
        this.prevPage});

  Settings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    page = json['page'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    data['page'] = this.page;
    data['next_page'] = this.nextPage;
    data['prev_page'] = this.prevPage;
    return data;
  }
}
