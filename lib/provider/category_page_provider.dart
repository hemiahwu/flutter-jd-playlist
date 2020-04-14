import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/category_content_model.dart';
import 'package:jd_app/net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];

  // 分类左侧
  loadCategoryPageData() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().reqeustData(JdApi.CATEGORY_NAV).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.data is List) {
        for (var i = 0; i < res.data.length; i++) {
          categoryNavList.add(res.data[i]);
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

  // 分类右侧
  loadCategoryContentData(int index) {
    isLoading = true;
    categoryContentList.clear();

    // 请求数据
    var data = {"title": categoryNavList[index]};
    NetRequest()
        .reqeustData(JdApi.CATEGORY_CONTENT, data: data, method: "post")
        .then((res) {
      isLoading = false;
      print(res.data);
      // if (res.data is List) {
      //   for (var i = 0; i < res.data.length; i++) {
      //     categoryNavList.add(res.data[i]);
      //   }
      // }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });

    notifyListeners();
  }
}
