import 'package:flutter/material.dart';

import '../config/jd_api.dart';
import '../net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = [];
  void loadCategoryPageData() {
    NetRequest().reqeustData(JdApi.CATEGORY_NAV).then((res) {
      if (res.data is List) {
        for (var i = 0; i < res.data.length; i++) {
          categoryNavList.add(res.data[i]);
        }
      }

      print(res.data);
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}
