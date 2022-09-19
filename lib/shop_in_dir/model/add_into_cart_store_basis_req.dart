// ignore_for_file: prefer_collection_literals, unnecessary_this

class AddIntoCartStoreBasisReq {
  bool? success;
  String? message;
  List<AddIntoCartStoreBasisReqData>? data;
  int? statusCode;

  AddIntoCartStoreBasisReq({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  AddIntoCartStoreBasisReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddIntoCartStoreBasisReqData>[];
      json['data'].forEach((v) {
        data!.add(AddIntoCartStoreBasisReqData.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class AddIntoCartStoreBasisReqData {
  String? vendorId;
  String? vendorName;
  String? vendorProfile;
  double? storeLatitude;
  double? storeLongitude;

  AddIntoCartStoreBasisReqData({
    this.vendorId,
    this.vendorName,
    this.vendorProfile,
    this.storeLatitude,
    this.storeLongitude,
  });

  AddIntoCartStoreBasisReqData.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorProfile = json['vendor_profile'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_profile'] = this.vendorProfile;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    return data;
  }
}
