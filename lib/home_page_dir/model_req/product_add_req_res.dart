// ignore_for_file: prefer_collection_literals, unnecessary_this

class ProdAddedReqRes {
  bool? success;
  String? message;
  ProdAddedReqResData? data;
  int? statusCode;

  ProdAddedReqRes({this.success, this.message, this.data, this.statusCode});

  ProdAddedReqRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  ProdAddedReqResData.fromJson(json['data']) : null;
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

class ProdAddedReqResData {
  int? id;
  int? user;
  String? addedProIntoCart;

  ProdAddedReqResData({this.id, this.user, this.addedProIntoCart});

  ProdAddedReqResData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    addedProIntoCart = json['added_pro_into_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['added_pro_into_cart'] = this.addedProIntoCart;
    return data;
  }
}
