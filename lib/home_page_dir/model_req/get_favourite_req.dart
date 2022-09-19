// ignore_for_file: prefer_collection_literals, unnecessary_this

class GetFavouriteReq {
  bool? success;
  String? message;
  List<GetFavouriteReqData>? data;
  int? statusCode;

  GetFavouriteReq({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  GetFavouriteReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFavouriteReqData>[];
      json['data'].forEach((v) {
        data!.add(GetFavouriteReqData.fromJson(v));
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

class GetFavouriteReqData {
  int? id;
  int? user;
  String? favProduct;

  GetFavouriteReqData({
    this.id,
    this.user,
    this.favProduct,
  });

  GetFavouriteReqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    favProduct = json['fav_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['fav_product'] = this.favProduct;
    return data;
  }
}
