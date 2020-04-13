import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/provider/category_page_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProvider>(
        create: (context) {
          var provider = new CategoryPageProvider();
          provider.loadCategoryPageData();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("分类"),
          ),
          body: Container(
            child: Consumer<CategoryPageProvider>(
              builder: (_, provider, __) {
                if (provider.isLoading) {
                  return Center(child: CupertinoActivityIndicator());
                }

                // 加载动画
                if (provider.isLoading) {
                  return Center(child: CupertinoActivityIndicator());
                }

                // 捕获异常
                if (provider.isError) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(provider.errorMsg),
                      OutlineButton(
                        child: Text("刷新"),
                        onPressed: () {
                          provider.loadCategoryPageData();
                        },
                      )
                    ],
                  ));
                }

                return Container();
              },
            ),
          ),
        ));
  }
}
