import 'ProductsDetailsModel.dart';

class GetCartListModel {
  List<CartList>? data;
  int? totalCartAmount;
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
  int amount;
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
        sleeve = (json['sleeve'] as List?)?.map((item) => Sleeve.fromJson(item)).toList() ?? [],
        neck = (json['neck'] as List?)?.map((item) => Neck.fromJson(item)).toList() ?? [],
        placket = (json['placket'] as List?)?.map((item) => Placket.fromJson(item)).toList() ?? [],
        pleat = (json['pleat'] as List?)?.map((item) => Pleat.fromJson(item)).toList() ?? [],
        size = json['size'] ?? "",
        color = json['color'] ?? "";

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
  int? rating;

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
