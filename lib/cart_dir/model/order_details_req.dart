class OrderDetailsReq {
  bool? success;
  String? message;
  List<OrderDetailsData>? data;
  int? statusCode;

  OrderDetailsReq({this.success, this.message, this.data, this.statusCode});

  OrderDetailsReq.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderDetailsData>[];
      json['data'].forEach((v) {
        data!.add( OrderDetailsData.fromJson(v));
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

class OrderDetailsData {
  String? orderId;
  String? consumer;
  String? vendorMasters;
  String? itemName;
  int? quantity;
  Null? unit;
  int? price;
  Null? tax;
  int? totalAmount;
  bool? isReady;
  bool? packed;
  bool? shipped;
  bool? delivered;
  bool? isReturn;
  String? orderCreateDate;
  String? orderUpdateDate;

  OrderDetailsData(
      {this.orderId,
        this.consumer,
        this.vendorMasters,
        this.itemName,
        this.quantity,
        this.unit,
        this.price,
        this.tax,
        this.totalAmount,
        this.isReady,
        this.packed,
        this.shipped,
        this.delivered,
        this.isReturn,
        this.orderCreateDate,
        this.orderUpdateDate});

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    consumer = json['consumer'];
    vendorMasters = json['vendor_masters'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    unit = json['unit'];
    price = json['price'];
    tax = json['tax'];
    totalAmount = json['total_amount'];
    isReady = json['is_ready'];
    packed = json['packed'];
    shipped = json['shipped'];
    delivered = json['delivered'];
    isReturn = json['is_return'];
    orderCreateDate = json['order_create_date'];
    orderUpdateDate = json['order_update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['consumer'] = this.consumer;
    data['vendor_masters'] = this.vendorMasters;
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['total_amount'] = this.totalAmount;
    data['is_ready'] = this.isReady;
    data['packed'] = this.packed;
    data['shipped'] = this.shipped;
    data['delivered'] = this.delivered;
    data['is_return'] = this.isReturn;
    data['order_create_date'] = this.orderCreateDate;
    data['order_update_date'] = this.orderUpdateDate;
    return data;
  }
}
