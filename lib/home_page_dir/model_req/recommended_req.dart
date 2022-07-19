// ignore_for_file: prefer_collection_literals, unnecessary_this

class RecommendedRequest {
  bool? success;
  String? message;
  List<RecommendedData>? data;
  int? statusCode;

  RecommendedRequest({this.success, this.message, this.data, this.statusCode});

  RecommendedRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RecommendedData>[];
      json['data'].forEach((v) {
        data!.add(RecommendedData.fromJson(v));
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

class RecommendedData {
  String? itemCode;
  String? itemName;
  double? offerPrice;
  String? itemImages;

  RecommendedData({
    this.itemCode,
    this.itemName,
    this.offerPrice,
    this.itemImages,
  });

  RecommendedData.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    offerPrice = json['offer_price'];
    itemImages = json['item_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['offer_price'] = this.offerPrice;
    data['item_images'] = this.itemImages;
    return data;
  }
}
