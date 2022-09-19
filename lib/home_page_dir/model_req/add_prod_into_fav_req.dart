// ignore_for_file: prefer_collection_literals, unnecessary_this

class AddProdIntoFavReq {
  bool? success;
  String? message;
  AddProdIntoFavReqData? data;
  int? statusCode;

  AddProdIntoFavReq({this.success, this.message, this.data, this.statusCode,});

  AddProdIntoFavReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? AddProdIntoFavReqData.fromJson(json['data'])
        : null;
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

class AddProdIntoFavReqData {
  int? id;
  int? user;
  String? favProduct;

  AddProdIntoFavReqData({
    this.id,
    this.user,
    this.favProduct,
  });

  AddProdIntoFavReqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    favProduct = json['fav_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['fav_product'] = this.favProduct;
    return data;
  }
}
