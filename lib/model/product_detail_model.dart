class ProductDetailModel {
  PartData partData;
  List<Baitiao> baitiao;

  ProductDetailModel({this.partData, this.baitiao});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    partData = json['partData'] != null
        ? new PartData.fromJson(json['partData'])
        : null;
    if (json['baitiao'] != null) {
      baitiao = new List<Baitiao>();
      json['baitiao'].forEach((v) {
        baitiao.add(new Baitiao.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.partData != null) {
      data['partData'] = this.partData.toJson();
    }
    if (this.baitiao != null) {
      data['baitiao'] = this.baitiao.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartData {
  String id;
  List<String> loopImgUrl;
  String title;
  String price;
  int count;

  PartData({this.id, this.loopImgUrl, this.title, this.price, this.count});

  PartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loopImgUrl = json['loopImgUrl'].cast<String>();
    title = json['title'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loopImgUrl'] = this.loopImgUrl;
    data['title'] = this.title;
    data['price'] = this.price;
    data['count'] = this.count;
    return data;
  }
}

class Baitiao {
  String desc;
  String tip;
  bool select;

  Baitiao({this.desc, this.tip, this.select});

  Baitiao.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    tip = json['tip'];
    select = json['select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['tip'] = this.tip;
    data['select'] = this.select;
    return data;
  }
}
