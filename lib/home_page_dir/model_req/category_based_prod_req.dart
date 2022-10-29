class CategoryBasedProductReq {
  bool? success;
  String? message;
  List<CategoryBasedProductData>? data;
  int? statusCode;

  CategoryBasedProductReq(
      {this.success, this.message, this.data, this.statusCode});

  CategoryBasedProductReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryBasedProductData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryBasedProductData.fromJson(v));
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

class CategoryBasedProductData {
  String? itemCode;
  String? itemName;
  double? offerPrice;
  double? price;
  String? itemImages;
  String? mFG;
  int? itemCategory;
  String? itemBrands;
  String? vendorMasters;
  String? description;
  String? tags;
  String? vendorId;
  String? vendorName;

  CategoryBasedProductData(
      {this.itemCode,
        this.itemName,
        this.offerPrice,
        this.price,
        this.itemImages,
        this.mFG,
        this.itemCategory,
        this.itemBrands,
        this.vendorMasters,
        this.description,
        this.tags,
        this.vendorId,
        this.vendorName});

  CategoryBasedProductData.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    offerPrice = json['offer_price'];
    price = json['price'];
    itemImages = json['item_images'];
    mFG = json['MFG'];
    itemCategory = json['item_category'];
    itemBrands = json['item_brands'];
    vendorMasters = json['vendor_masters'];
    description = json['description'];
    tags = json['tags'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['offer_price'] = this.offerPrice;
    data['price'] = this.price;
    data['item_images'] = this.itemImages;
    data['MFG'] = this.mFG;
    data['item_category'] = this.itemCategory;
    data['item_brands'] = this.itemBrands;
    data['vendor_masters'] = this.vendorMasters;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}
