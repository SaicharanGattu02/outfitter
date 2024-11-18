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
  dynamic address; // Change to dynamic to handle both String and Address

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

    // Handle address field
    if (json['address'] != null) {
      // Check if the address is a map or a string
      if (json['address'] is String) {
        address = json['address']; // Assign the string directly
      } else {
        address = Address.fromJson(json['address']); // Deserialize as Address object
      }
    }
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

    // If address is an Address object, convert it to JSON
    if (this.address is Address) {
      data['address'] = (this.address as Address).toJson();
    } else {
      // If address is a string, directly assign it
      data['address'] = this.address;
    }

    return data;
  }
}
class Address {
  String? id;
  String? mobile;
  String? alternateMobile;
  String? fullName;
  bool? default_address;
  String? address;
  String? addressType;
  String? pincode;

  Address(
      {this.id,
      this.mobile,
      this.alternateMobile,
      this.fullName,
      this.default_address,
      this.address,
      this.addressType,
      this.pincode});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    fullName = json['full_name'];
    default_address = json['default'];
    address = json['address'];
    addressType = json['address_type'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['full_name'] = this.fullName;
    data['default'] = this.default_address;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
