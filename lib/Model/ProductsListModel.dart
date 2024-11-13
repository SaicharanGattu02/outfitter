class ProductsListModel {
  List<ProductsList>? data;
  Settings? settings;

  ProductsListModel({this.data, this.settings});

  ProductsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductsList>[];
      json['data'].forEach((v) {
        data!.add(new ProductsList.fromJson(v));
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

class ProductsList {
  String? id;
  String? title;
  String? category;
  String? brand;
  String? postedBy;
  int? mrp;
  int? salePrice;

  ProductsList(
      {this.id,
        this.title,
        this.category,
        this.brand,
        this.postedBy,
        this.mrp,
        this.salePrice});

  ProductsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    brand = json['brand'];
    postedBy = json['posted_by'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['posted_by'] = this.postedBy;
    data['mrp'] = this.mrp;
    data['sale_price'] = this.salePrice;
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
