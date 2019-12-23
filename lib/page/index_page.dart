import 'package:flutter/material.dart';
import 'package:jd_app/page/home_page.dart';
import 'package:jd_app/page/category_page.dart';
import 'package:jd_app/page/cart_page.dart';
import 'package:jd_app/page/user_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
      ),
      body: IndexedStack(
        // 层布局控件 只显示一个
        children: <Widget>[
          HomePage(),
          CategoryPage(),
          CartPage(),
          UserPage(),
        ],
      ),
    );
  }
}
