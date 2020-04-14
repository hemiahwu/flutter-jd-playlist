class ProductInfoModel {
  String id;
  String cover;
  String title;
  String price;
  String comment;
  String rate;

  ProductInfoModel(
      {this.id, this.cover, this.title, this.price, this.comment, this.rate});

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'];
    title = json['title'];
    price = json['price'];
    comment = json['comment'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cover'] = this.cover;
    data['title'] = this.title;
    data['price'] = this.price;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    return data;
  }
}
