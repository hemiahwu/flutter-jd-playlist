import 'package:flutter/material.dart';
import 'package:jd_app/page/index_page.dart';
import 'package:provider/provider.dart';
import 'package:jd_app/provider/bottom_navi_provider.dart';

void main() => runApp(
    ChangeNotifierProvider.value(value: BottomNaviProvider(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
