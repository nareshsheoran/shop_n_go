// ignore_for_file: prefer_collection_literals, unnecessary_this

// class GetFavouriteReq {
//   bool? success;
//   String? message;
//   List<GetFavouriteReqData>? data;
//   int? statusCode;
//
//   GetFavouriteReq({
//     this.success,
//     this.message,
//     this.data,
//     this.statusCode,
//   });
//
//   GetFavouriteReq.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <GetFavouriteReqData>[];
//       json['data'].forEach((v) {
//         data!.add(GetFavouriteReqData.fromJson(v));
//       });
//     }
//     statusCode = json['status_code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['status_code'] = this.statusCode;
//     return data;
//   }
// }
//
// class GetFavouriteReqData {
//   int? id;
//   int? user;
//   String? favProduct;
//
//   GetFavouriteReqData({
//     this.id,
//     this.user,
//     this.favProduct,
//   });
//
//   GetFavouriteReqData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'];
//     favProduct = json['fav_product'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user'] = this.user;
//     data['fav_product'] = this.favProduct;
//     return data;
//   }
// }


class GetFavouriteReq {
  bool? success;
  String? message;
  List<GetFavouriteReqData>? data;
  int? statusCode;

  GetFavouriteReq({this.success, this.message, this.data, this.statusCode});

  GetFavouriteReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFavouriteReqData>[];
      json['data'].forEach((v) {
        data!.add(new GetFavouriteReqData.fromJson(v));
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

class GetFavouriteReqData {
  int? id;
  int? consumerId;
  String? itemCode;
  String? storeId;
  String? itemName;
  String? itemImages;
  double? offerPrice;
  String? description;
  String? vendorId;
  String? vendorName;

  GetFavouriteReqData(
      {this.id,
        this.consumerId,
        this.itemCode,
        this.storeId,
        this.itemName,
        this.itemImages,
        this.offerPrice,
        this.description,
        this.vendorId,
        this.vendorName});

  GetFavouriteReqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consumerId = json['consumer_id'];
    itemCode = json['item_code'];
    storeId = json['store_id'];
    itemName = json['item_name'];
    itemImages = json['item_images'];
    offerPrice = json['offer_price'];
    description = json['description'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consumer_id'] = this.consumerId;
    data['item_code'] = this.itemCode;
    data['store_id'] = this.storeId;
    data['item_name'] = this.itemName;
    data['item_images'] = this.itemImages;
    data['offer_price'] = this.offerPrice;
    data['description'] = this.description;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}
