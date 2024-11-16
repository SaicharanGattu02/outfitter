class ProductsDetailsModel {
  ProductDetails? data;
  Settings? settings;

  ProductsDetailsModel({this.data, this.settings});

  ProductsDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProductDetails.fromJson(json['data']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  String? id;
  bool isInWishlist; // Default to false if null
  int rating; // Default to 0 if null
  String title;
  String category;
  List<String> colors; // Default to an empty list if null
  String brand;
  int mrp; // Default to 0 if null
  int salePrice; // Default to 0 if null
  String postedBy;
  String description;
  String productDetails;
  String shippingDetails;
  List<Review> reviews; // Default to an empty list if null
  List<Sleeve> sleeve; // Default to an empty list if null
  List<Neck> neck; // Default to an empty list if null
  List<Placket> placket; // Default to an empty list if null
  List<Pleat> pleat; // Default to an empty list if null
  String image;
  List<String> size; // Default to an empty list if null

  ProductDetails({
    this.id,
    bool? isInWishlist,
    int? rating,
    String? title,
    String? category,
    List<String>? colors,
    String? brand,
    int? mrp,
    int? salePrice,
    String? postedBy,
    String? description,
    String? productDetails,
    String? shippingDetails,
    List<Review>? reviews,
    List<Sleeve>? sleeve,
    List<Neck>? neck,
    List<Placket>? placket,
    List<Pleat>? pleat,
    String? image,
    List<String>? size,
  })  : isInWishlist = isInWishlist ?? false, // Default to false
        rating = rating ?? 0, // Default to 0
        title = title ?? '', // Default to empty string
        category = category ?? '', // Default to empty string
        colors = colors ?? [], // Default to empty list
        brand = brand ?? '', // Default to empty string
        mrp = mrp ?? 0, // Default to 0
        salePrice = salePrice ?? 0, // Default to 0
        postedBy = postedBy ?? '', // Default to empty string
        description = description ?? '', // Default to empty string
        productDetails = productDetails ?? '', // Default to empty string
        shippingDetails = shippingDetails ?? '', // Default to empty string
        reviews = reviews ?? [], // Default to empty list
        sleeve = sleeve ?? [], // Default to empty list
        neck = neck ?? [], // Default to empty list
        placket = placket ?? [], // Default to empty list
        pleat = pleat ?? [], // Default to empty list
        image = image ?? '', // Default to empty string
        size = size ?? []; // Default to empty list

  // Handling JSON conversion: fromJson
  ProductDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        isInWishlist = json['is_in_wishlist'] ?? false,
        rating = json['rating'] ?? 0,
        title = json['title'] ?? '',
        category = json['category'] ?? '',
        colors = json['colors'] != null ? List<String>.from(json['colors']) : [],
        brand = json['brand'] ?? '',
        mrp = json['mrp'] ?? 0,
        salePrice = json['sale_price'] ?? 0,
        postedBy = json['posted_by'] ?? '',
        description = json['description'] ?? '',
        productDetails = json['product_details'] ?? '',
        shippingDetails = json['shipping_details'] ?? '',
        reviews = json['reviews'] != null
            ? (json['reviews'] as List).map((v) => Review.fromJson(v)).toList()
            : [],
        sleeve = json['sleeve'] != null
            ? (json['sleeve'] as List).map((v) => Sleeve.fromJson(v)).toList()
            : [],
        neck = json['neck'] != null
            ? (json['neck'] as List).map((v) => Neck.fromJson(v)).toList()
            : [],
        placket = json['placket'] != null
            ? (json['placket'] as List).map((v) => Placket.fromJson(v)).toList()
            : [],
        pleat = json['pleat'] != null
            ? (json['pleat'] as List).map((v) => Pleat.fromJson(v)).toList()
            : [],
        image = json['image'] ?? '',
        size = json['size'] != null ? List<String>.from(json['size']) : [];

  // Handling JSON conversion: toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (reviews.isNotEmpty) {
      data['reviews'] = reviews.map((v) => v.toJson()).toList();
    }
    if (sleeve.isNotEmpty) {
      data['sleeve'] = sleeve.map((v) => v.toJson()).toList();
    }
    if (neck.isNotEmpty) {
      data['neck'] = neck.map((v) => v.toJson()).toList();
    }
    if (placket.isNotEmpty) {
      data['placket'] = placket.map((v) => v.toJson()).toList();
    }
    if (pleat.isNotEmpty) {
      data['pleat'] = pleat.map((v) => v.toJson()).toList();
    }
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

  Sleeve.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
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
  // Assuming the review has more fields, here is a placeholder
  final String? comment;

  Review({
    this.comment,
  });

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
