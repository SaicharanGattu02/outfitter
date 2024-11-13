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
  String? title;
  String? category;
  String? brand;
  int? mrp;
  int? salePrice;
  String? postedBy;
  String? description;
  String? productDetails;
  String? shippingDetails;
  String? reviews;
  // List<Null>? sleeve;
  // List<Null>? neck;
  // List<Null>? placket;
  // List<Null>? pleat;
  String? image;
  // List<Null>? size;

  ProductDetails(
      {this.id,
        this.title,
        this.category,
        this.brand,
        this.mrp,
        this.salePrice,
        this.postedBy,
        this.description,
        this.productDetails,
        this.shippingDetails,
        this.reviews,
        // this.sleeve,
        // this.neck,
        // this.placket,
        // this.pleat,
        this.image,
        // this.size
      });

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    brand = json['brand'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    postedBy = json['posted_by'];
    description = json['description'];
    productDetails = json['product_details'];
    shippingDetails = json['shipping_details'];
    reviews = json['reviews'];
  //   if (json['sleeve'] != null) {
  //     sleeve = <Null>[];
  //     json['sleeve'].forEach((v) {
  //       sleeve!.add(new Null.fromJson(v));
  //     });
  //   }
  //   if (json['neck'] != null) {
  //     neck = <Null>[];
  //     json['neck'].forEach((v) {
  //       neck!.add(new Null.fromJson(v));
  //     });
  //   }
  //   if (json['placket'] != null) {
  //     placket = <Null>[];
  //     json['placket'].forEach((v) {
  //       placket!.add(new Null.fromJson(v));
  //     });
  //   }
  //   if (json['pleat'] != null) {
  //     pleat = <Null>[];
  //     json['pleat'].forEach((v) {
  //       pleat!.add(new Null.fromJson(v));
  //     });
  //   }
  //   image = json['image'];
  //   if (json['size'] != null) {
  //     size = <Null>[];
  //     json['size'].forEach((v) {
  //       size!.add(new Null.fromJson(v));
  //     });
  //   }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['mrp'] = this.mrp;
    data['sale_price'] = this.salePrice;
    data['posted_by'] = this.postedBy;
    data['description'] = this.description;
    data['product_details'] = this.productDetails;
    data['shipping_details'] = this.shippingDetails;
    data['reviews'] = this.reviews;
    // if (this.sleeve != null) {
    //   data['sleeve'] = this.sleeve!.map((v) => v.toJson()).toList();
    // }
    // if (this.neck != null) {
    //   data['neck'] = this.neck!.map((v) => v.toJson()).toList();
    // }
    // if (this.placket != null) {
    //   data['placket'] = this.placket!.map((v) => v.toJson()).toList();
    // }
    // if (this.pleat != null) {
    //   data['pleat'] = this.pleat!.map((v) => v.toJson()).toList();
    // }
    // data['image'] = this.image;
    // if (this.size != null) {
    //   data['size'] = this.size!.map((v) => v.toJson()).toList();
    // }
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
