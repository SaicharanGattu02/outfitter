class ProductDetailsModel {
  String id;
  String title;
  String category;
  String? brand;
  double mrp;
  double salePrice;
  String postedBy;
  String description;
  String productDetails;
  String shippingDetails;
  double reviews;
  String image;
  List<dynamic> sleeve;
  List<dynamic> neck;
  List<dynamic> placket;
  List<dynamic> pleat;
  List<dynamic> size;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.category,
    this.brand,
    required this.mrp,
    required this.salePrice,
    required this.postedBy,
    required this.description,
    required this.productDetails,
    required this.shippingDetails,
    required this.reviews,
    required this.image,
    required this.sleeve,
    required this.neck,
    required this.placket,
    required this.pleat,
    required this.size,
  });

  // Factory constructor to create ProductDetails from JSON
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['data']['id'],
      title: json['data']['title'],
      category: json['data']['category'],
      brand: json['data']['brand'],
      mrp: json['data']['mrp'].toDouble(),
      salePrice: json['data']['sale_price'].toDouble(),
      postedBy: json['data']['posted_by'],
      description: json['data']['description'],
      productDetails: json['data']['product_details'],
      shippingDetails: json['data']['shipping_details'],
      reviews: json['data']['reviews']?.toDouble() ?? 0.0,
      image: json['data']['image'],
      sleeve: List<dynamic>.from(json['data']['sleeve'] ?? []),
      neck: List<dynamic>.from(json['data']['neck'] ?? []),
      placket: List<dynamic>.from(json['data']['placket'] ?? []),
      pleat: List<dynamic>.from(json['data']['pleat'] ?? []),
      size: List<dynamic>.from(json['data']['size'] ?? []),
    );
  }

  // Method to convert ProductDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'title': title,
        'category': category,
        'brand': brand,
        'mrp': mrp,
        'sale_price': salePrice,
        'posted_by': postedBy,
        'description': description,
        'product_details': productDetails,
        'shipping_details': shippingDetails,
        'reviews': reviews,
        'image': image,
        'sleeve': sleeve,
        'neck': neck,
        'placket': placket,
        'pleat': pleat,
        'size': size,
      },
    };
  }
}