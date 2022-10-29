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
        data!.add( AllCategoryData.fromJson(v));
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
  String? images;

  AllCategoryData({this.id, this.name, this.images,});

  AllCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['images'] = this.images;
    return data;
  }
}
