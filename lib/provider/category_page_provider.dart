import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/category_content_model.dart';
import 'package:jd_app/net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = []; // 左侧导航栏容器
  List<CategoryContentModel> categoryContentList = []; // 右侧商品
  int tabIndex = 0;

  // 分类左侧导航栏
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
        loadCategoryContentData(this.tabIndex);
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

  // 分类右侧商品
  void loadCategoryContentData(int index) {
    this.tabIndex = index;
    isLoading = true;
    categoryContentList.clear();
    notifyListeners();
    var data = {"title": categoryNavList[index]};
    NetRequest()
        .reqeustData(JdApi.CATEGORY_CONTENT, data: data, method: "post")
        .then((res) {
      print(res.data);
      if (res.data is List) {
        for (var item in res.data) {
          CategoryContentModel tmpModel = CategoryContentModel.fromJson(item);
          categoryContentList.add(tmpModel);
        }
      }
      isLoading = false;
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
