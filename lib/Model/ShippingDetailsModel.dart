class ShippingDetailsModel {
  ShippingData? data;
  Settings? settings;

  ShippingDetailsModel({this.data, this.settings});

  ShippingDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ShippingData.fromJson(json['data']) : null;
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  Address? address;

  ShippingData({
    this.id,
    this.handlingCharges,
    this.shippingFee,
    this.deliveryCharges,
    this.discount,
    this.amount,
    this.totalAmount,
    this.address,
  });

  ShippingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handlingCharges = json['handling_charges'];
    shippingFee = json['shipping_fee'];
    deliveryCharges = json['delivery_charges'];
    discount = json['discount'];
    amount = json['amount'];
    totalAmount = json['total_amount'];

    // Handling address field, checking if it's an object or missing
    address = json['address'] != null && json['address'] is Map<String, dynamic>
        ? Address.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['handling_charges'] = this.handlingCharges;
    data['shipping_fee'] = this.shippingFee;
    data['delivery_charges'] = this.deliveryCharges;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;

    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }

    return data;
  }
}

class Address {
  String? id;
  String? mobile;
  String? alternateMobile;
  String? fullName;
  bool? defaultAddress;
  String? address;
  String? addressType;
  String? pincode;

  Address({
    this.id,
    this.mobile,
    this.alternateMobile,
    this.fullName,
    this.defaultAddress,
    this.address,
    this.addressType,
    this.pincode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    fullName = json['full_name'];
    defaultAddress = json['default'];
    address = json['address'];
    addressType = json['address_type'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['full_name'] = this.fullName;
    data['default'] = this.defaultAddress;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['pincode'] = this.pincode;
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
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
