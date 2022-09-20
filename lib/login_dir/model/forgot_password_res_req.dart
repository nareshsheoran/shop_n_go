class ForgotPasswordResReq {
  bool? success;
  String? message;
  String? data;
  int? statusCode;

  ForgotPasswordResReq(
      {this.success, this.message, this.data, this.statusCode});

  ForgotPasswordResReq.fromJson(Map<String, dynamic> json) {
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
