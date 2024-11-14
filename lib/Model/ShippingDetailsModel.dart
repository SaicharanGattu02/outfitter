class ShippingDetailsModel {
  ShippingData? data;
  Settings? settings;

  ShippingDetailsModel({this.data, this.settings});

  ShippingDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShippingData.fromJson(json['data']) : null;
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

class ShippingData {
  String? id;
  int? handlingCharges;
  int? shippingFee;
  int? deliveryCharges;
  int? discount;
  int? amount;
  int? totalAmount;

  ShippingData(
      {this.id,
        this.handlingCharges,
        this.shippingFee,
        this.deliveryCharges,
        this.discount,
        this.amount,
        this.totalAmount});

  ShippingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handlingCharges = json['handling_charges'];
    shippingFee = json['shipping_fee'];
    deliveryCharges = json['delivery_charges'];
    discount = json['discount'];
    amount = json['amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['handling_charges'] = this.handlingCharges;
    data['shipping_fee'] = this.shippingFee;
    data['delivery_charges'] = this.deliveryCharges;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
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
