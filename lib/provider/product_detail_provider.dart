import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/product_detail_model.dart';
import 'package:jd_app/net/net_request.dart';

class ProductDetailProvider with ChangeNotifier {
  ProductDetailModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadProduct({String id}) {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().reqeustData(JdApi.PRODUCTIONS_DETAIL).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductDetailModel tmpModel = ProductDetailModel.fromJson(item);

          if (tmpModel.partData.id == id) {
            model = tmpModel;
          }
        }
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

  // 切换分期模式
  void changeBaitiaoSeleted(int index) {
    List<Baitiao> list = [];
    if (this.model.baitiao[index] == false) {
      for (int i = 0; i < this.model.baitiao.length; i++) {
        if (i == index) {
          this.model.baitiao[i].select = true;
        } else {
          this.model.baitiao[i].select = false;
        }
        list.add(this.model.baitiao[i]);
      }
      this.model.baitiao.clear();
      this.model.baitiao.addAll(list);
      notifyListeners();
    }
  }
}
