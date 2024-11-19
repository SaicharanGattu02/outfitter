class ReviewsModel {
  List<Reviews>? data;
  Settings? settings;

  ReviewsModel({this.data, this.settings});

  // Constructor from JSON
  ReviewsModel.fromJson(Map<String, dynamic> json) {
    // Handle case where 'data' is null or empty
    if (json['data'] != null && json['data'] is List) {
      data = <Reviews>[];
      json['data'].forEach((v) {
        data!.add(Reviews.fromJson(v));
      });
    } else {
      data = [];  // Ensure data is an empty list if it's null or not a list
    }

    // Handle 'settings' being null
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Only include 'data' in the JSON if it's not null or empty
    if (this.data != null && this.data!.isNotEmpty) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    } else {
      data['data'] = []; // If data is null or empty, add an empty list
    }

    // Include 'settings' if it's not null
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }

    return data;
  }
}

class Reviews {
  String? id;
  int? rating;
  String? reviewText;
  String? customer;
  String? createdAt;

  Reviews({this.id, this.rating, this.reviewText, this.customer, this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    reviewText = json['review_text'];
    customer = json['customer'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['review_text'] = this.reviewText;
    data['customer'] = this.customer;
    data['created_at'] = this.createdAt;
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
