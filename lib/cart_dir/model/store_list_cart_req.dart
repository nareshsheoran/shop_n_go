class StoreListCartReq {
  bool? success;
  String? message;
  List<StoreListCartReqData>? data;
  int? statusCode;

  StoreListCartReq({this.success, this.message, this.data, this.statusCode});

  StoreListCartReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreListCartReqData>[];
      json['data'].forEach((v) {
        data!.add( StoreListCartReqData.fromJson(v));
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

class StoreListCartReqData {
  String? vendorId;
  String? vendorName;
  String? vendorProfile;
  int? itemCount;

  StoreListCartReqData({this.vendorId, this.vendorName, this.vendorProfile, this.itemCount});

  StoreListCartReqData.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorProfile = json['vendor_profile'];
    itemCount = json['item_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_profile'] = this.vendorProfile;
    data['item_count'] = this.itemCount;
    return data;
  }
}
