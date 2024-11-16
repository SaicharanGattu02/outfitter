class OrderDetailsModel {
  OrderDetails? orderDetail;
  Settings? settings;

  OrderDetailsModel({this.orderDetail, this.settings});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderDetail =
    json['data'] != null ? new OrderDetails.fromJson(json['data']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetail != null) {
      data['data'] = this.orderDetail!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String? id;
  String? status;
  String? paymentMethod;
  bool? isPaid;
  List<Items>? items;
  Address? address;
  int? orderValue;
  Product? product;

  OrderDetails(
      {this.id,
        this.status,
        this.paymentMethod,
        this.isPaid,
        this.items,
        this.address,
        this.orderValue,
        this.product});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    isPaid = json['is_paid'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderValue = json['order_value'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['is_paid'] = this.isPaid;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_value'] = this.orderValue;
    data['product'] = this.product;
    return data;
  }
}

class Items {
  String? id;
  Product? product;
  int? quantity;
  int? amount;

  Items({this.id, this.product, this.quantity, this.amount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    return data;
  }
}

class Product {
  String? id;
  String? title;
  String? category;
  String? brand;
  Null? colors;
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
    colors = json['colors'];
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

class Address {
  String? id;
  String? mobile;
  String? alternateMobile;
  String? fullName;
  bool? default_address;
  String? address;
  String? addressType;
  String? pincode;

  Address(
      {this.id,
        this.mobile,
        this.alternateMobile,
        this.fullName,
        this.default_address,
        this.address,
        this.addressType,
        this.pincode});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    fullName = json['full_name'];
    default_address = json['default'];
    address = json['address'];
    addressType = json['address_type'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['full_name'] = this.fullName;
    data['default'] = this.default_address;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['pincode'] = this.pincode;
    return data;
  }
}

class Settings {
  int? success;
  String? message;
  int? status;

  Settings({this.success, this.message, this.status});

  Settings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}