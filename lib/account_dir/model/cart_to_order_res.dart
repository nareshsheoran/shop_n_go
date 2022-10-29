class CartToOrderRes {
  bool? success;
  String? message;
  String? data;
  int? statusCode;

  CartToOrderRes({this.success, this.message, this.data, this.statusCode});

  CartToOrderRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = this.data;
    data['status_code'] = this.statusCode;
    return data;
  }
}
