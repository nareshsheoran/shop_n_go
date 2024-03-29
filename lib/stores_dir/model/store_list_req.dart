// ignore_for_file: unnecessary_this, prefer_collection_literals

class StoreListRequest {
  bool? success;
  String? message;
  List<StoreListData>? data;
  int? statusCode;

  StoreListRequest({this.success, this.message, this.data, this.statusCode});

  StoreListRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreListData>[];
      json['data'].forEach((v) {
        data!.add( StoreListData.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class StoreListData {
  String? vendorId;
  String? vendorName;
  String? authPerson;
  String? vendorProfile;
  String? isHomeDelivery;
  String? distance;
  int? minimumOrder;
  String? openTime;
  String? closeTime;
  int? noOfProduct;

  StoreListData(
      {this.vendorId,
        this.vendorName,
        this.authPerson,
        this.vendorProfile,
        this.isHomeDelivery,
        this.distance,
        this.minimumOrder,
        this.openTime,
        this.closeTime,
        this.noOfProduct});

  StoreListData.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    authPerson = json['auth_person'];
    vendorProfile = json['vendor_profile'];
    isHomeDelivery = json['is_home_delivery'];
    distance = json['distance'];
    minimumOrder = json['minimum_order'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    noOfProduct = json['No_Of_Product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['auth_person'] = this.authPerson;
    data['vendor_profile'] = this.vendorProfile;
    data['is_home_delivery'] = this.isHomeDelivery;
    data['distance'] = this.distance;
    data['minimum_order'] = this.minimumOrder;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['No_Of_Product'] = this.noOfProduct;
    return data;
  }
}

