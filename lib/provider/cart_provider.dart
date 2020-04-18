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
    List<String> list = prefs.getStringList("cartInfo");

    // 判断出去来的list有没有东西
    if (list == null) {
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
        list.add(json.encode(tmpData.toJson()));
      }

      // 如果缓存里没有这个商品,那么直接添加
      if (isUpdated == false) {
        list.add(json.encode(data.toJson()));
        models.add(data);
      }

      // 存入缓存
      prefs.setStringList("cartInfo", list);

      // 通知听众
      notifyListeners();
    }
  }
}
