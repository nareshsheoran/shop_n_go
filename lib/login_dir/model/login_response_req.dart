// ignore_for_file: prefer_collection_literals, unnecessary_this

class LoginResponseRequest {
  String? expiry;
  String? token;

  LoginResponseRequest({
    this.expiry,
    this.token,
  });

  LoginResponseRequest.fromJson(Map<String, dynamic> json) {
    expiry = json['expiry'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['expiry'] = this.expiry;
    data['token'] = this.token;
    return data;
  }
}
