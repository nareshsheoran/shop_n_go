class BestSellerRequest {
  bool? success;
  String? message;
  List<BestSellerData>? data;
  int? statusCode;

  BestSellerRequest({this.success, this.message, this.data, this.statusCode});

  BestSellerRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BestSellerData>[];
      json['data'].forEach((v) {
        data!.add(new BestSellerData.fromJson(v));
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

class BestSellerData {
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
  String? updateAt;
  int? itemCategory;
  int? itemSubCategory;
  String? itemBrands;
  String? vendorId;
  String? vendorName;

  BestSellerData(
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
        this.updateAt,
        this.itemCategory,
        this.itemSubCategory,
        this.itemBrands,
        this.vendorId,
        this.vendorName});

  BestSellerData.fromJson(Map<String, dynamic> json) {
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
    updateAt = json['update_at'];
    itemCategory = json['item_category'];
    itemSubCategory = json['item_sub_category'];
    itemBrands = json['item_brands'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
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
    data['update_at'] = this.updateAt;
    data['item_category'] = this.itemCategory;
    data['item_sub_category'] = this.itemSubCategory;
    data['item_brands'] = this.itemBrands;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}
