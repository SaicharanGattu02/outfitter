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
  double averageRating;
  int totalPeople;
  RatingStats ratingStats;
  String title;
  String category;
  List<String> colors;
  String? brand;
  bool isBestSeller;
  int mrp;
  int salePrice;
  String postedBy;
  String description;
  String productDetails;
  String shippingDetails;
  List<Sleeve> sleeve;
  List<Neck> neck;
  List<Placket> placket;
  List<Pleat> pleat;
  String image;
  List<String> size;
  List<Review> recentReviews;

  ProductDetails({
    this.id,
    this.isInWishlist = false,
    this.averageRating = 0.0,
    this.totalPeople = 0,
    required this.ratingStats,
    this.title = '',
    this.category = '',
    this.colors = const [],
    this.brand,
    this.isBestSeller = false,
    this.mrp = 0,
    this.salePrice = 0,
    this.postedBy = '',
    this.description = '',
    this.productDetails = '',
    this.shippingDetails = '',
    this.sleeve = const [],
    this.neck = const [],
    this.placket = const [],
    this.pleat = const [],
    this.image = '',
    this.size = const [],
    this.recentReviews = const [],
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      isInWishlist: json['is_in_wishlist'] ?? false,
      averageRating: json['rating_stats'] != null ? json['rating_stats']['average_rating'] ?? 0.0 : 0.0,
      totalPeople: json['rating_stats'] != null ? json['rating_stats']['total_people'] ?? 0 : 0,
      ratingStats: RatingStats.fromJson(json['rating_stats'] ?? {}),
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
      brand: json['brand'],
      isBestSeller: json['is_best_seller'] ?? false,
      mrp: json['mrp'] ?? 0,
      salePrice: json['sale_price'] ?? 0,
      postedBy: json['posted_by'] ?? '',
      description: json['description'] ?? '',
      productDetails: json['product_details'] ?? '',
      shippingDetails: json['shipping_details'] ?? '',
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
      recentReviews: json['recent_reviews'] != null
          ? (json['recent_reviews'] as List).map((v) => Review.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['is_in_wishlist'] = isInWishlist;
    data['rating_stats'] = ratingStats.toJson();
    data['average_rating'] = averageRating;
    data['total_people'] = totalPeople;
    data['title'] = title;
    data['category'] = category;
    data['colors'] = colors;
    data['brand'] = brand;
    data['is_best_seller'] = isBestSeller;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    data['posted_by'] = postedBy;
    data['description'] = description;
    data['product_details'] = productDetails;
    data['shipping_details'] = shippingDetails;
    if (sleeve.isNotEmpty) data['sleeve'] = sleeve.map((v) => v.toJson()).toList();
    if (neck.isNotEmpty) data['neck'] = neck.map((v) => v.toJson()).toList();
    if (placket.isNotEmpty) data['placket'] = placket.map((v) => v.toJson()).toList();
    if (pleat.isNotEmpty) data['pleat'] = pleat.map((v) => v.toJson()).toList();
    data['image'] = image;
    data['size'] = size;
    if (recentReviews.isNotEmpty) data['recent_reviews'] = recentReviews.map((v) => v.toJson()).toList();
    return data;
  }
}

class RatingStats {
  Map<String, double> ratingsGroup;
  double averageRating;
  int totalPeople;

  RatingStats({
    required this.ratingsGroup,
    required this.averageRating,
    required this.totalPeople,
  });

  factory RatingStats.fromJson(Map<String, dynamic> json) {
    return RatingStats(
      ratingsGroup: {
        '1': json['ratings_group']['1']['percentage']?.toDouble() ?? 0.0,
        '2': json['ratings_group']['2']['percentage']?.toDouble() ?? 0.0,
        '3': json['ratings_group']['3']['percentage']?.toDouble() ?? 0.0,
        '4': json['ratings_group']['4']['percentage']?.toDouble() ?? 0.0,
        '5': json['ratings_group']['5']['percentage']?.toDouble() ?? 0.0,
      },
      averageRating: json['average_rating']?.toDouble() ?? 0.0,
      totalPeople: json['total_people'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratings_group': ratingsGroup,
      'average_rating': averageRating,
      'total_people': totalPeople,
    };
  }
}

class Review {
  final String? id;
  final int? rating;
  final String? comment;
  final String? customer;
  final DateTime? createdAt;

  Review({
    this.id,
    this.rating,
    this.comment,
    this.customer,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      comment: json['review_text'],
      customer: json['customer'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'review_text': comment,
      'customer': customer,
      'created_at': createdAt?.toIso8601String(),
    };
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
