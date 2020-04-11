class HomePageModel {
  List<Swipers> swipers;
  List<Logos> logos;
  List<Quicks> quicks;
  PageRow pageRow;

  HomePageModel({this.swipers, this.logos, this.quicks, this.pageRow});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['swipers'] != null) {
      swipers = new List<Swipers>();
      json['swipers'].forEach((v) {
        swipers.add(new Swipers.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = new List<Logos>();
      json['logos'].forEach((v) {
        logos.add(new Logos.fromJson(v));
      });
    }
    if (json['quicks'] != null) {
      quicks = new List<Quicks>();
      json['quicks'].forEach((v) {
        quicks.add(new Quicks.fromJson(v));
      });
    }
    pageRow =
        json['pageRow'] != null ? new PageRow.fromJson(json['pageRow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.swipers != null) {
      data['swipers'] = this.swipers.map((v) => v.toJson()).toList();
    }
    if (this.logos != null) {
      data['logos'] = this.logos.map((v) => v.toJson()).toList();
    }
    if (this.quicks != null) {
      data['quicks'] = this.quicks.map((v) => v.toJson()).toList();
    }
    if (this.pageRow != null) {
      data['pageRow'] = this.pageRow.toJson();
    }
    return data;
  }
}

class Swipers {
  String image;

  Swipers({this.image});

  Swipers.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Logos {
  String image;
  String title;

  Logos({this.image, this.title});

  Logos.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class Quicks {
  String image;
  String price;

  Quicks({this.image, this.price});

  Quicks.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}

class PageRow {
  List<String> ad1;
  List<String> ad2;

  PageRow({this.ad1, this.ad2});

  PageRow.fromJson(Map<String, dynamic> json) {
    ad1 = json['ad1'].cast<String>();
    ad2 = json['ad2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    return data;
  }
}
