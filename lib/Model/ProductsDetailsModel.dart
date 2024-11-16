class ProductsDetailsModel {
  ProductDetails? data;
  Settings? settings;

  ProductsDetailsModel({this.data, this.settings});

  ProductsDetailsModel.fromJson(Map<String, dynamic> json)
      : data = json['data'] != null ? ProductDetails.fromJson(json['data']) : null,
        settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) data['data'] = this.data!.toJson();
    if (this.settings != null) data['settings'] = this.settings!.toJson();
    return data;
  }
}

class ProductDetails {
  String? id;
  bool isInWishlist;
  double rating;
  String title;
  String category;
  List<String> colors;
  String? brand;
  int mrp;
  int salePrice;
  String postedBy;
  String description;
  String productDetails;
  String shippingDetails;
  List<Review> reviews;
  List<Sleeve> sleeve;
  List<Neck> neck;
  List<Placket> placket;
  List<Pleat> pleat;
  String image;
  List<String> size;

  ProductDetails({
    this.id,
    this.isInWishlist = false,
    this.rating = 0.0,
    this.title = '',
    this.category = '',
    this.colors = const [],
    this.brand,
    this.mrp = 0,
    this.salePrice = 0,
    this.postedBy = '',
    this.description = '',
    this.productDetails = '',
    this.shippingDetails = '',
    this.reviews = const [],
    this.sleeve = const [],
    this.neck = const [],
    this.placket = const [],
    this.pleat = const [],
    this.image = '',
    this.size = const [],
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      isInWishlist: json['is_in_wishlist'] ?? false,
      rating: json['rating'] ?? 0.0,
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
      brand: json['brand'],
      mrp: json['mrp'] ?? 0,
      salePrice: json['sale_price'] ?? 0,
      postedBy: json['posted_by'] ?? '',
      description: json['description'] ?? '',
      productDetails: json['product_details'] ?? '',
      shippingDetails: json['shipping_details'] ?? '',
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((v) => Review.fromJson(v)).toList()
          : [],
      sleeve: json['sleeve'] != null
          ? (json['sleeve'] as List).map((v) => Sleeve.fromJson(v)).toList()
          : [],
      neck: json['neck'] != null
          ? (json['neck'] as List).map((v) => Neck.fromJson(v)).toList()
          : [],
      placket: json['placket'] != null
          ? (json['placket'] as List).map((v) => Placket.fromJson(v)).toList()
          : [],
      pleat: json['pleat'] != null
          ? (json['pleat'] as List).map((v) => Pleat.fromJson(v)).toList()
          : [],
      image: json['image'] ?? '',
      size: json['size'] != null ? List<String>.from(json['size']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['is_in_wishlist'] = isInWishlist;
    data['rating'] = rating;
    data['title'] = title;
    data['category'] = category;
    data['colors'] = colors;
    data['brand'] = brand;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    data['posted_by'] = postedBy;
    data['description'] = description;
    data['product_details'] = productDetails;
    data['shipping_details'] = shippingDetails;
    if (reviews.isNotEmpty) data['reviews'] = reviews.map((v) => v.toJson()).toList();
    if (sleeve.isNotEmpty) data['sleeve'] = sleeve.map((v) => v.toJson()).toList();
    if (neck.isNotEmpty) data['neck'] = neck.map((v) => v.toJson()).toList();
    if (placket.isNotEmpty) data['placket'] = placket.map((v) => v.toJson()).toList();
    if (pleat.isNotEmpty) data['pleat'] = pleat.map((v) => v.toJson()).toList();
    data['image'] = image;
    data['size'] = size;
    return data;
  }
}

class Sleeve {
  String? id;
  String? name;
  String? image;

  Sleeve({this.id, this.name, this.image});

  factory Sleeve.fromJson(Map<String, dynamic> json) {
    return Sleeve(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

class Neck {
  final String id;
  final String name;
  final String image;

  Neck({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Neck.fromJson(Map<String, dynamic> json) {
    return Neck(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

class Placket {
  final String id;
  final String name;
  final String image;

  Placket({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Placket.fromJson(Map<String, dynamic> json) {
    return Placket(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

class Pleat {
  final String id;
  final String name;
  final String image;

  Pleat({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Pleat.fromJson(Map<String, dynamic> json) {
    return Pleat(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

class Review {
  final String? comment;

  Review({this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
    };
  }
}

class Settings {
  int? success;
  String? message;
  int? status;

  Settings({this.success, this.message, this.status});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      success: json['success'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'status': status,
    };
  }
}
