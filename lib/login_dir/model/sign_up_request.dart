class SignUpRequest {
  String? userName;
  String? email;
  String? password;

  SignUpRequest({
    this.userName,
    this.email,
    this.password,
  });

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
