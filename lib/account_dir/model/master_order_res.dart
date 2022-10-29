class MasterOrderRes {
  bool? success;
  String? message;
  List<MasterOrderResData>? data;
  int? statusCode;

  MasterOrderRes({this.success, this.message, this.data, this.statusCode});

  MasterOrderRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MasterOrderResData>[];
      json['data'].forEach((v) {
        data!.add(new MasterOrderResData.fromJson(v));
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

class MasterOrderResData {
  String? mainOrderId;
  String? consumerId;
  String? orderDate;
  String? orderType;
  String? deliveryDate;
  String? orderStatus;
  String? storeId;

  MasterOrderResData(
      {this.mainOrderId,
        this.consumerId,
        this.orderDate,
        this.orderType,
        this.deliveryDate,
        this.orderStatus,
        this.storeId,});

  MasterOrderResData.fromJson(Map<String, dynamic> json) {
    mainOrderId = json['main_order_id'];
    consumerId = json['consumer_id'];
    orderDate = json['order_date'];
    orderType = json['order_type'];
    deliveryDate = json['delivery_date'];
    orderStatus = json['order_status'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_order_id'] = this.mainOrderId;
    data['consumer_id'] = this.consumerId;
    data['order_date'] = this.orderDate;
    data['order_type'] = this.orderType;
    data['delivery_date'] = this.deliveryDate;
    data['order_status'] = this.orderStatus;
    data['store_id'] = this.storeId;
    return data;
  }
}
