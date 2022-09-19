// ignore_for_file: prefer_collection_literals, unnecessary_this

class AllCartProductReq {
  bool? success;
  String? message;
  List<AllCartProductData>? data;
  int? statusCode;

  AllCartProductReq({this.success, this.message, this.data, this.statusCode});

  AllCartProductReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllCartProductData>[];
      json['data'].forEach((v) {
        data!.add( AllCartProductData.fromJson(v));
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

class AllCartProductData {
  int? id;
  int? user;
  String? addedProIntoCart;

  AllCartProductData({this.id, this.user, this.addedProIntoCart});

  AllCartProductData.fromJson(Map<String, dynamic> json) {
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
