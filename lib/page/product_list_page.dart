import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  ProductListPage({Key key, this.title}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("${widget.title}")), body: Container()),
    );
  }
}
