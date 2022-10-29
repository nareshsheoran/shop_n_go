class MasterOrderDetailsRes {
  bool? success;
  String? message;
  List<MasterOrderDetailsData>? data;
  int? statusCode;

  MasterOrderDetailsRes(
      {this.success, this.message, this.data, this.statusCode});

  MasterOrderDetailsRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MasterOrderDetailsData>[];
      json['data'].forEach((v) {
        data!.add( MasterOrderDetailsData.fromJson(v));
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

class MasterOrderDetailsData {
  int? id;
  String? consumerId;
  String? indivisualOrderId;
  double? itemPrice;
  String? productImage;
  String? productTitle;
  int? itemQuantity;
  String? mainOrderId;
  String? storeId;
  String? itemCode;

  MasterOrderDetailsData(
      {this.id,
        this.consumerId,
        this.indivisualOrderId,
        this.itemPrice,
        this.productImage,
        this.productTitle,
        this.itemQuantity,
        this.mainOrderId,
        this.storeId,
        this.itemCode});

  MasterOrderDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consumerId = json['consumer_id'];
    indivisualOrderId = json['indivisual_order_id'];
    itemPrice = json['item_price'];
    productImage = json['product_image'];
    productTitle = json['product_title'];
    itemQuantity = json['item_quantity'];
    mainOrderId = json['main_order_id'];
    storeId = json['store_id'];
    itemCode = json['item_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consumer_id'] = this.consumerId;
    data['indivisual_order_id'] = this.indivisualOrderId;
    data['item_price'] = this.itemPrice;
    data['product_image'] = this.productImage;
    data['product_title'] = this.productTitle;
    data['item_quantity'] = this.itemQuantity;
    data['main_order_id'] = this.mainOrderId;
    data['store_id'] = this.storeId;
    data['item_code'] = this.itemCode;
    return data;
  }
}
