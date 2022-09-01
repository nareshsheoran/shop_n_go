class ProductRequest {
  String? user;
  String? prodICart;

  ProductRequest({
    this.user,
    this.prodICart,
  });

  ProductRequest.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    prodICart = json['added_pro_into_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['added_pro_into_cart'] = this.prodICart;
    return data;
  }
}
