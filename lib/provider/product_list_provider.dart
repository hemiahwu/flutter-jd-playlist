import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/net/net_request.dart';

class ProductListProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadProductList() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().reqeustData(JdApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      print(res.data);
      if (res.code == 200) {
        // print(res.data);

        // print(model.toJson());
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
