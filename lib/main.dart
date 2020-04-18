import 'package:flutter/material.dart';
import 'package:jd_app/page/index_page.dart';
import 'package:jd_app/provider/bottom_navi_provider.dart';
import 'package:jd_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BottomNaviProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(create: (context) {
          CartProvider provider = new CartProvider();
          // provider.getCartList();
          return provider;
        })
      ],
      child: Consumer<CartProvider>(builder: (context, provider, __) {
        return MyApp();
      }),
    ));

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
