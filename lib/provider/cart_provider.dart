import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jd_app/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];

  Future<void> addToCart(PartData data) async {
    // print(data.toJson());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 取出缓存
    // List<String> list = [];
    // list = prefs.getStringList("cartInfo");
    // print(list);

    // 存入缓存
    // List<String> list = [];
    // list.add(json.encode(data.toJson()));
    // prefs.setStringList("cartInfo", list);

    // 先把缓存里的数据取出来
    List<String> list = [];
    list.addAll(prefs.getStringList("cartInfo"));

    // 判断出去来的list有没有东西
    if (list.length == 0) {
      // print("缓存里没有任何商品数据");
      // 将传过来的数据放到数组中
      list.add(json.encode(data.toJson()));
      // 存到缓存
      prefs.setStringList("cartInfo", list);
      // 更新本地数据
      models.add(data);
      // 通知听众
      notifyListeners();
    } else {
      // print("缓存中有商品数据");
      List<String> tmpList = [];
      // 判断缓存中是否有对应的商品
      bool isUpdated = false;
      // 遍历缓存数组
      for (var i = 0; i < list.length; i++) {
        // 拿到数组中每一个模型
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        // 判断商品id
        if (tmpData.id == data.id) {
          // print("count: ${data.count}");
          tmpData.count = data.count;
          isUpdated = true;
        }
        // 放到数组中
        String tmpDataStr = json.encode(tmpData.toJson());
        tmpList.add(tmpDataStr);
        models.add(tmpData);
      }

      // 如果缓存里没有这个商品,那么直接添加
      if (isUpdated == false) {
        String str = json.encode(data.toJson());
        tmpList.add(str);
        models.add(data);
      }

      // 存入缓存
      prefs.setStringList("cartInfo", tmpList);

      // 通知听众
      notifyListeners();
    }
  }

  // 获取购物车商品数量
  int getAllCount() {
    int count = 0;
    for (PartData data in this.models) {
      count += data.count;
    }
    return count;
  }
}
