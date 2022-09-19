// ignore_for_file: prefer_collection_literals, unnecessary_this

class UserProfileRequest {
  bool? success;
  String? message;
  UserProfileRequestData? data;
  int? statusCode;

  UserProfileRequest({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  UserProfileRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? UserProfileRequestData.fromJson(json['data'])
        : null;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class UserProfileRequestData {
  int? id;
  String? username;
  String? email;
  String? dateJoined;

  UserProfileRequestData({
    this.id,
    this.username,
    this.email,
    this.dateJoined,
  });

  UserProfileRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    dateJoined = json['date_joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['date_joined'] = this.dateJoined;
    return data;
  }
}
