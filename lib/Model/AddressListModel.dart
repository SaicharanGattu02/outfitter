class AddressListModel {
  List<AddressList>? data;
  Settings? settings;

  AddressListModel({this.data, this.settings});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddressList>[];
      json['data'].forEach((v) {
        data!.add(new AddressList.fromJson(v));
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

class AddressList {
  String? id;
  String? mobile;
  String? name;
  String? address;
  String? addressType;
  bool? default_address;
  String? pincode;

  AddressList(
      {this.id,
        this.mobile,
        this.name,
        this.address,
        this.addressType,
        this.default_address,
        this.pincode});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    name = json['full_name'];
    address = json['address'];
    addressType = json['address_type'];
    pincode = json['pincode'];
    default_address = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['full_name'] = this.name;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['pincode'] = this.pincode;
    data['default'] = this.default_address;
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
