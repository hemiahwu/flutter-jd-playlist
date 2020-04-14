class CategoryContentModel {
  List<Data> data;

  CategoryContentModel({this.data});

  CategoryContentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String title;
  List<Desc> desc;

  Data({this.title, this.desc});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['desc'] != null) {
      desc = new List<Desc>();
      json['desc'].forEach((v) {
        desc.add(new Desc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.desc != null) {
      data['desc'] = this.desc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String text;
  String img;

  Desc({this.text, this.img});

  Desc.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['img'] = this.img;
    return data;
  }
}
