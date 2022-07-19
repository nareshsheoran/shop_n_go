// ignore_for_file: prefer_collection_literals, unnecessary_this

class LoginRequest {
  String? userName;
  String? password;

  LoginRequest({
    this.userName,
    this.password,
  });

  LoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}
