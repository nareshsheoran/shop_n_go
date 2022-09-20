class AddAddressResReq {
  bool? success;
  String? message;
  AddAddressResReqData? data;
  int? statusCode;

  AddAddressResReq({this.success, this.message, this.data, this.statusCode});

  AddAddressResReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  AddAddressResReqData.fromJson(json['data']) : null;
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

class AddAddressResReqData {
  int? id;
  String? users;
  String? buildingNoOrName;
  String? landmark;
  int? pincode;
  String? area;
  String? city;

  AddAddressResReqData(
      {this.id,
        this.users,
        this.buildingNoOrName,
        this.landmark,
        this.pincode,
        this.area,
        this.city});

  AddAddressResReqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    users = json['users'];
    buildingNoOrName = json['Building_no_or_name'];
    landmark = json['Landmark'];
    pincode = json['Pincode'];
    area = json['Area'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users'] = this.users;
    data['Building_no_or_name'] = this.buildingNoOrName;
    data['Landmark'] = this.landmark;
    data['Pincode'] = this.pincode;
    data['Area'] = this.area;
    data['City'] = this.city;
    return data;
  }
}
