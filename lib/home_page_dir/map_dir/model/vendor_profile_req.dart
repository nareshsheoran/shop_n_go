// ignore_for_file: unnecessary_this, prefer_collection_literals

class VendorProfileReq {
  bool? success;
  String? message;
  VendorProfileReqData? data;
  int? statusCode;

  VendorProfileReq({this.success, this.message, this.data, this.statusCode});

  VendorProfileReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  VendorProfileReqData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class VendorProfileReqData {
  String? vendorId;
  String? vendorName;
  String? authPerson;
  String? gSTNO;
  String? businessType;
  String? emailId;
  String? contactNo;
  String? vendorProduct;
  String? vendorProfile;
  String? address;
  String? description;
  String? isHomeDelivery;
  String? distance;
  double? storeLatitude;
  double? storeLongitude;
  int? minimumOrder;
  String? openTime;
  String? closeTime;
  int? noOfProducts;
  String? createAt;

  VendorProfileReqData(
      {this.vendorId,
        this.vendorName,
        this.authPerson,
        this.gSTNO,
        this.businessType,
        this.emailId,
        this.contactNo,
        this.vendorProduct,
        this.vendorProfile,
        this.address,
        this.description,
        this.isHomeDelivery,
        this.distance,
        this.storeLatitude,
        this.storeLongitude,
        this.minimumOrder,
        this.openTime,
        this.closeTime,
        this.noOfProducts,
        this.createAt});

  VendorProfileReqData.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    authPerson = json['auth_person'];
    gSTNO = json['GST_NO'];
    businessType = json['business_type'];
    emailId = json['email_id'];
    contactNo = json['contact_no'];
    vendorProduct = json['vendor_product'];
    vendorProfile = json['vendor_profile'];
    address = json['address'];
    description = json['description'];
    isHomeDelivery = json['is_home_delivery'];
    distance = json['distance'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    minimumOrder = json['minimum_order'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    noOfProducts = json['no_of_products'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['auth_person'] = this.authPerson;
    data['GST_NO'] = this.gSTNO;
    data['business_type'] = this.businessType;
    data['email_id'] = this.emailId;
    data['contact_no'] = this.contactNo;
    data['vendor_product'] = this.vendorProduct;
    data['vendor_profile'] = this.vendorProfile;
    data['address'] = this.address;
    data['description'] = this.description;
    data['is_home_delivery'] = this.isHomeDelivery;
    data['distance'] = this.distance;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    data['minimum_order'] = this.minimumOrder;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['no_of_products'] = this.noOfProducts;
    data['create_at'] = this.createAt;
    return data;
  }
}
