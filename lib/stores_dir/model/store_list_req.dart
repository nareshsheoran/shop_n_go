// ignore_for_file: prefer_collection_literals, unnecessary_this

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
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  String? gSTNO;
  String? businessType;
  String? emailId;
  String? contactNo;
  String? vendorProduct;
  String? vendorProfile;
  String? address;
  String? description;

  StoreListData(
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
        this.description});

  StoreListData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
