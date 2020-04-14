import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/product_info_model.dart';
import 'package:jd_app/net/net_request.dart';

class ProductListProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<ProductInfoModel> list = List();

  loadProductList() {
    print('1');
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().reqeustData(JdApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      if (res.code == 200 && res.data is List) {
        print(res.data);
        print('1');
        for (var i = 0; i < res.data.length; i++) {
          ProductInfoModel tmpModel = ProductInfoModel.fromJson(res.data[i]);
          list.add(tmpModel);
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
}
