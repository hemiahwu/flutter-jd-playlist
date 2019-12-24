import 'package:flutter/material.dart';
import 'package:jd_app/page/home_page.dart';
import 'package:jd_app/page/category_page.dart';
import 'package:jd_app/page/cart_page.dart';
import 'package:jd_app/page/user_page.dart';

import 'package:provider/provider.dart';
import 'package:jd_app/provider/bottom_navi_provider.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar:
        Consumer<BottomNaviProvider>(builder: (_, mProvider, __) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("分类"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("购物车"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("我的"),
          ),
        ],
        onTap: (index) {
          // print(index);
          // setState(() {
          //   _currentIndex = index;
          // });
          mProvider.changeBottomNaviIndex(index);
        },
      );
    }), body: Consumer<BottomNaviProvider>(builder: (_, mProvider, __) {
      return IndexedStack(
        index: mProvider.bottomNaviIndex,
        // 层布局控件 只显示一个
        children: <Widget>[
          HomePage(),
          CategoryPage(),
          CartPage(),
          UserPage(),
        ],
      );
    }));
  }
}
