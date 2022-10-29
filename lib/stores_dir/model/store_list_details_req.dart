class StoreListDetailsReq {
  bool? success;
  String? message;
  List<StoreListDetailsData>? data;
  int? statusCode;

  StoreListDetailsReq({this.success, this.message, this.data, this.statusCode});

  StoreListDetailsReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreListDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new StoreListDetailsData.fromJson(v));
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

class StoreListDetailsData {
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

  StoreListDetailsData(
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
        this.vendorId});

  StoreListDetailsData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
