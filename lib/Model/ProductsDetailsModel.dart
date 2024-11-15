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
  bool? isInWishlist;
  int? rating;
  String? title;
  String? category;
  List<String>? colors;
  String? brand;
  int? mrp;
  int? salePrice;
  String? postedBy;
  String? description;
  String? productDetails;
  String? shippingDetails;
  List<Review>? reviews;
  List<Sleeve>? sleeve;
  List<Neck>? neck;
  List<Placket>? placket;
  List<Pleat>? pleat;
  String? image;
  List<String>? size;

  ProductDetails(
      {this.id,
        this.isInWishlist,
        this.rating,
        this.title,
        this.category,
        this.colors,
        this.brand,
        this.mrp,
        this.salePrice,
        this.postedBy,
        this.description,
        this.productDetails,
        this.shippingDetails,
        this.reviews,
        this.sleeve,
        this.neck,
        this.placket,
        this.pleat,
        this.image,
        this.size});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isInWishlist = json['is_in_wishlist'];
    rating = json['rating'];
    title = json['title'];
    category = json['category'];
    colors = json['colors'].cast<String>();
    brand = json['brand'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    postedBy = json['posted_by'];
    description = json['description'];
    productDetails = json['product_details'];
    shippingDetails = json['shipping_details'];
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Review.fromJson(v));
      });
    }
    if (json['sleeve'] != null) {
      sleeve = <Sleeve>[];
      json['sleeve'].forEach((v) {
        sleeve!.add(new Sleeve.fromJson(v));
      });
    }
    if (json['neck'] != null) {
      neck = <Neck>[];
      json['neck'].forEach((v) {
        neck!.add(new Neck.fromJson(v));
      });
    }
    if (json['placket'] != null) {
      placket = <Placket>[];
      json['placket'].forEach((v) {
        placket!.add(new Placket.fromJson(v));
      });
    }
    if (json['pleat'] != null) {
      pleat = <Pleat>[];
      json['pleat'].forEach((v) {
        pleat!.add(new Pleat.fromJson(v));
      });
    }
    image = json['image'];
    size = json['size'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_in_wishlist'] = this.isInWishlist;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['category'] = this.category;
    data['colors'] = this.colors;
    data['brand'] = this.brand;
    data['mrp'] = this.mrp;
    data['sale_price'] = this.salePrice;
    data['posted_by'] = this.postedBy;
    data['description'] = this.description;
    data['product_details'] = this.productDetails;
    data['shipping_details'] = this.shippingDetails;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.sleeve != null) {
      data['sleeve'] = this.sleeve!.map((v) => v.toJson()).toList();
    }
    if (this.neck != null) {
      data['neck'] = this.neck!.map((v) => v.toJson()).toList();
    }
    if (this.placket != null) {
      data['placket'] = this.placket!.map((v) => v.toJson()).toList();
    }
    if (this.pleat != null) {
      data['pleat'] = this.pleat!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['size'] = this.size;
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
