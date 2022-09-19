// ignore_for_file: prefer_collection_literals, unnecessary_this

class NearByStoresReq {
  bool? success;
  String? message;
  List<NearByStoresReqData>? data;
  int? statusCode;

  NearByStoresReq({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  NearByStoresReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NearByStoresReqData>[];
      json['data'].forEach((v) {
        data!.add(NearByStoresReqData.fromJson(v));
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

class NearByStoresReqData {
  String? vendorId;
  String? vendorName;
  String? vendorProfile;
  String? address;
  double? storeLatitude;
  double? storeLongitude;

  NearByStoresReqData({
    this.vendorId,
    this.vendorName,
    this.vendorProfile,
    this.address,
    this.storeLatitude,
    this.storeLongitude,
  });

  NearByStoresReqData.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorProfile = json['vendor_profile'];
    address = json['address'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_profile'] = this.vendorProfile;
    data['address'] = this.address;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    return data;
  }
}
