class GetCartListModel {
  List<CartList>? data;
  Settings? settings;

  GetCartListModel({this.data, this.settings});

  GetCartListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CartList>[];
      json['data'].forEach((v) {
        data!.add(new CartList.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class CartList {
  String? id;
  Product? product;
  int? quantity;

  CartList({this.id, this.product, this.quantity});

  CartList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  String? id;
  String? title;
  String? category;
  Null? brand;
  List<String>? colors;
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
        this.brand,
        this.colors,
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
    brand = json['brand'];

   colors = (json['colors'] as List?)?.cast<String>() ?? [];

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
    data['brand'] = this.brand;
    data['colors'] = this.colors;
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
