// ignore_for_file: prefer_collection_literals, unnecessary_this

class ProductDetailsReq {
  bool? success;
  String? message;
  ProductDetailsData? data;
  int? statusCode;

  ProductDetailsReq({this.success, this.message, this.data, this.statusCode});

  ProductDetailsReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  ProductDetailsData.fromJson(json['data']) : null;
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

class ProductDetailsData {
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
  String? description;
  String? uploadAt;
  int? itemCategory;
  int? itemSubCategory;
  String? itemBrands;

  ProductDetailsData(
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
        this.description,
        this.uploadAt,
        this.itemCategory,
        this.itemSubCategory,
        this.itemBrands});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
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
    description = json['description'];
    uploadAt = json['upload_at'];
    itemCategory = json['item_category'];
    itemSubCategory = json['item_sub_category'];
    itemBrands = json['item_brands'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
    data['description'] = this.description;
    data['upload_at'] = this.uploadAt;
    data['item_category'] = this.itemCategory;
    data['item_sub_category'] = this.itemSubCategory;
    data['item_brands'] = this.itemBrands;
    return data;
  }
}
