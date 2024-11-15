class OrdersListModel {
  List<OrdersList>? data;
  Settings? settings;

  OrdersListModel({this.data, this.settings});

  OrdersListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrdersList>[];
      json['data'].forEach((v) {
        data!.add(new OrdersList.fromJson(v));
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

class OrdersList {
  String? id;
  String? orderid;
  String? status;
  String? paymentMethod;
  bool? isPaid;
  int? orderValue;
  String? createdAt;

  OrdersList(
      {this.id,
      this.orderid,
        this.status,
        this.paymentMethod,
        this.isPaid,
        this.orderValue,
        this.createdAt});

  OrdersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['order_id'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    isPaid = json['is_paid'];
    orderValue = json['order_value'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderid;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['is_paid'] = this.isPaid;
    data['order_value'] = this.orderValue;
    data['created_at'] = this.createdAt;
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
