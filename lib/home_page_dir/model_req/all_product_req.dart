class AllProductRequest {
  bool? success;
  String? message;
  List<AllProductData>? data;
  int? statusCode;

  AllProductRequest({this.success, this.message, this.data, this.statusCode});

  AllProductRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllProductData>[];
      json['data'].forEach((v) {
        data!.add(new AllProductData.fromJson(v));
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

class AllProductData {
  String? itemCode;
  String? itemName;
  double? offerPrice;
  String? itemImages;
  String? description;
  String? vendorId;
  String? vendorName;

  AllProductData(
      {this.itemCode,
        this.itemName,
        this.offerPrice,
        this.itemImages,
        this.description,
        this.vendorId,
        this.vendorName});

  AllProductData.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    offerPrice = json['offer_price'];
    itemImages = json['item_images'];
    description = json['description'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['offer_price'] = this.offerPrice;
    data['item_images'] = this.itemImages;
    data['description'] = this.description;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}
