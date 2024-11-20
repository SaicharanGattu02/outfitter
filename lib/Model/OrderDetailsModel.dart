class OrderDetailsModel {
  OrderDetails? data;
  Settings? settings;

  OrderDetailsModel({this.data, this.settings});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? OrderDetails.fromJson(json['data']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String? id;
  String? orderId;
  String? status;
  String? paymentMethod;
  bool? isPaid;
  List<Items>? items;
  Address? address;
  num? orderValue;  // Changed from int? to num?
  Product? product;
  Shipping? shipping;

  OrderDetails({
    this.id,
    this.orderId,
    this.status,
    this.paymentMethod,
    this.isPaid,
    this.items,
    this.address,
    this.orderValue,
    this.product,
    this.shipping,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    isPaid = json['is_paid'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    orderValue = json['order_value'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    shipping = json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['order_id'] = this.orderId;
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
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  Product? product;
  int? quantity;
  num? amount;  // Changed from int? to num?

  Items({this.id, this.product, this.quantity, this.amount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    amount = json['amount'];  // Can be double or int
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  bool? isBestSeller;
  String? brand;
  String? postedBy;
  num? mrp;  // Changed from int? to num?
  num? salePrice;  // Changed from int? to num?
  bool? isInWishlist;
  String? image;


  Product({
    this.id,
    this.title,
    this.category,
    this.isBestSeller,
    this.brand,
    this.postedBy,
    this.mrp,
    this.salePrice,
    this.isInWishlist,
    this.image,
  });

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}

class Address {
  String? id;
  String? mobile;
  String? alternateMobile;
  String? fullName;
  bool? defaultAddress;
  String? address;
  String? addressType;
  String? pincode;

  Address({
    this.id,
    this.mobile,
    this.alternateMobile,
    this.fullName,
    this.defaultAddress,
    this.address,
    this.addressType,
    this.pincode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    fullName = json['full_name'];
    defaultAddress = json['default'];
    address = json['address'];
    addressType = json['address_type'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['full_name'] = this.fullName;
    data['default'] = this.defaultAddress;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['pincode'] = this.pincode;
    return data;
  }
}

class Shipping {
  String? id;
  num? handlingCharges;  // Changed from int? to num?
  num? shippingFee;  // Changed from int? to num?
  num? deliveryCharges;  // Changed from int? to num?
  num? discount;  // Changed from int? to num?
  num? totalAmount;  // Changed from int? to num?
  num? saleAmount;  // Changed from int? to num?

  Shipping({
    this.id,
    this.handlingCharges,
    this.shippingFee,
    this.deliveryCharges,
    this.discount,
    this.totalAmount,
    this.saleAmount,
  });

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handlingCharges = json['handling_charges'];
    shippingFee = json['shipping_fee'];
    deliveryCharges = json['delivery_charges'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    saleAmount = json['sale_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['handling_charges'] = this.handlingCharges;
    data['shipping_fee'] = this.shippingFee;
    data['delivery_charges'] = this.deliveryCharges;
    data['discount'] = this.discount;
    data['total_amount'] = this.totalAmount;
    data['sale_amount'] = this.saleAmount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
