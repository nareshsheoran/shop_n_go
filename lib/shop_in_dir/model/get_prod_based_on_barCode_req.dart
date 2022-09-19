// ignore_for_file: prefer_collection_literals, unnecessary_this

class GetProductBasedOnBarCodeReq {
  bool? success;
  String? message;
  GetProductBasedOnBarCodeReqData? data;
  int? statusCode;

  GetProductBasedOnBarCodeReq(
      {this.success, this.message, this.data, this.statusCode});

  GetProductBasedOnBarCodeReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? GetProductBasedOnBarCodeReqData.fromJson(json['data'])
        : null;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class GetProductBasedOnBarCodeReqData {
  String? itemCode;
  String? vendorMasters;
  String? itemName;
  double? price;
  double? offerPrice;
  String? itemSku;
  String? color;
  String? size;
  String? weight;
  String? itemImages;
  String? tags;
  String? mFG;
  String? expiaryDate;
  int? rating;
  String? barcodeSequence;
  String? description;
  String? uploadAt;
  int? itemCategory;
  int? itemSubCategory;
  String? itemBrands;

  GetProductBasedOnBarCodeReqData(
      {this.itemCode,
      this.vendorMasters,
      this.itemName,
      this.price,
      this.offerPrice,
      this.itemSku,
      this.color,
      this.size,
      this.weight,
      this.itemImages,
      this.tags,
      this.mFG,
      this.expiaryDate,
      this.rating,
      this.barcodeSequence,
      this.description,
      this.uploadAt,
      this.itemCategory,
      this.itemSubCategory,
      this.itemBrands});

  GetProductBasedOnBarCodeReqData.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    vendorMasters = json['vendor_masters'];
    itemName = json['item_name'];
    price = json['price'];
    offerPrice = json['offer_price'];
    itemSku = json['item_sku'];
    color = json['color'];
    size = json['size'];
    weight = json['weight'];
    itemImages = json['item_images'];
    tags = json['tags'];
    mFG = json['MFG'];
    expiaryDate = json['expiary_date'];
    rating = json['rating'];
    barcodeSequence = json['barcode_sequence'];
    description = json['description'];
    uploadAt = json['upload_at'];
    itemCategory = json['item_category'];
    itemSubCategory = json['item_sub_category'];
    itemBrands = json['item_brands'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['vendor_masters'] = this.vendorMasters;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['item_sku'] = this.itemSku;
    data['color'] = this.color;
    data['size'] = this.size;
    data['weight'] = this.weight;
    data['item_images'] = this.itemImages;
    data['tags'] = this.tags;
    data['MFG'] = this.mFG;
    data['expiary_date'] = this.expiaryDate;
    data['rating'] = this.rating;
    data['barcode_sequence'] = this.barcodeSequence;
    data['description'] = this.description;
    data['upload_at'] = this.uploadAt;
    data['item_category'] = this.itemCategory;
    data['item_sub_category'] = this.itemSubCategory;
    data['item_brands'] = this.itemBrands;
    return data;
  }
}
