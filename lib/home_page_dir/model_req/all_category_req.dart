class AllCategoryRequest {
  bool? success;
  String? message;
  List<AllCategoryData>? data;
  int? statusCode;

  AllCategoryRequest({this.success, this.message, this.data, this.statusCode});

  AllCategoryRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new AllCategoryData.fromJson(v));
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

class AllCategoryData {
  int? id;
  String? name;

  AllCategoryData({this.id, this.name});

  AllCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
