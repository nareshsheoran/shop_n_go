class CartItemByStoreReq {
  bool? success;
  String? message;
  List<CartItemByStoreReqData>? data;
  int? statusCode;

  CartItemByStoreReq({this.success, this.message, this.data, this.statusCode});

  CartItemByStoreReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartItemByStoreReqData>[];
      json['data'].forEach((v) {
        data!.add(new CartItemByStoreReqData.fromJson(v));
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

class CartItemByStoreReqData {
  String? itemCode;
  String? itemName;
  String? itemImages;
  double? offerPrice;
  String? description;
  int? id;
  int? quantity;
  int? consumerId;
  String? storeId;
  String? vendorId;
  String? vendorName;
  int? storeRating;
  String? distance;
  String? isHomeDelivery;

  CartItemByStoreReqData(
      {this.itemCode,
        this.itemName,
        this.itemImages,
        this.offerPrice,
        this.description,
        this.id,
        this.quantity,
        this.consumerId,
        this.storeId,
        this.vendorId,
        this.vendorName,
        this.storeRating,
        this.distance,
        this.isHomeDelivery});

  CartItemByStoreReqData.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemImages = json['item_images'];
    offerPrice = json['offer_price'];
    description = json['description'];
    id = json['id'];
    quantity = json['quantity'];
    consumerId = json['consumer_id'];
    storeId = json['store_id'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    storeRating = json['store_rating'];
    distance = json['distance'];
    isHomeDelivery = json['is_home_delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_images'] = this.itemImages;
    data['offer_price'] = this.offerPrice;
    data['description'] = this.description;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['consumer_id'] = this.consumerId;
    data['store_id'] = this.storeId;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['store_rating'] = this.storeRating;
    data['distance'] = this.distance;
    data['is_home_delivery'] = this.isHomeDelivery;
    return data;
  }
}
