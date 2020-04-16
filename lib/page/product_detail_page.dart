import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/model/product_detail_model.dart';
import 'package:jd_app/provider/product_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  ProductDetailPage({Key key, this.id}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("京东")),
      body: Container(
        child: Consumer<ProductDetailProvider>(
          builder: (_, provider, __) {
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
                      provider.loadProduct(id: widget.id);
                    },
                  )
                ],
              ));
            }

            // 获取model
            ProductDetailModel model = provider.model;
            String baitiaoTitle = "【白条支付】首单享立减优惠";
            print(model.toJson());

            for (var item in model.baitiao) {
              if (item.select == true) {
                baitiaoTitle = item.desc;
              }
            }

            return Stack(
              children: <Widget>[
                // 主体内容
                ListView(
                  children: <Widget>[
                    // 轮播图
                    buildSwiperContainer(model),

                    // 标题
                    buildTitleContainer(model),

                    // 价格
                    buildPriceContainer(model),

                    // 白条支付
                    buildPayContainer(context, baitiaoTitle, model),

                    // 商品件数
                    buildCountContainer(model),
                  ],
                ),

                // 底部菜单栏
                buildbottomPositioned()
              ],
            );
          },
        ),
      ),
    );
  }

  Positioned buildbottomPositioned() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(width: 1, color: Color(0xFFE8E8ED)))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      Text(
                        "购物车",
                        style: TextStyle(fontSize: 13.0),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // 购物车
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: 60,
                  color: Color(0xFFe93b3d),
                  alignment: Alignment.center,
                  child: Text(
                    "加入购物车",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  // 加入购物车
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildCountContainer(ProductDetailModel model) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
            bottom: BorderSide(width: 1, color: Color(0xFFE8E8ED))),
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              "已选",
              style: TextStyle(color: Color(0xFF9999999)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("${model.partData.count}件"),
              ),
            ),
            Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          // 选择商品个数
        },
      ),
    );
  }

  Container buildPayContainer(
      BuildContext context, String baitiaoTitle, ProductDetailModel model) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
            bottom: BorderSide(width: 1, color: Color(0xFFE8E8ED))),
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              "支付",
              style: TextStyle(color: Color(0xFF9999999)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("$baitiaoTitle"),
              ),
            ),
            Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          // 选择支付方式 白条支付 分期
          // print(baitiaoTitle);
          showBaitiao(context, model);
        },
      ),
    );
  }

  Future showBaitiao(BuildContext context, ProductDetailModel model) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              // 顶部标题栏
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    color: Color(0xFFF3F2F8),
                    child: Center(
                      child: Text(
                        "打白条购买",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    width: 40.0,
                    height: 40.0,
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 20,
                        onPressed: () {
                          // 关闭
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),

              // 主体列表
              Container(
                margin: EdgeInsets.only(top: 40.0, bottom: 50.0),
                child: ListView.builder(
                    itemCount: model.baitiao.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Image.asset(
                                "assets/image/unselect.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${model.baitiao[index].desc}"),
                                  Text("${model.baitiao[index].tip}"),
                                ],
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          // 选择分期类型
                        },
                      );
                    }),
              ),

              // 底部的按钮
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    color: Color(0xFFE4393C),
                    child: Center(
                      child: Text(
                        "立即打白条",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    // 确定分期并返回
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  Container buildPriceContainer(ProductDetailModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(
        "¥${model.partData.price}",
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFe93b3d)),
      ),
    );
  }

  Container buildTitleContainer(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(
        model.partData.title,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildSwiperContainer(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      height: 400,
      child: Swiper(
        itemCount: model.partData.loopImgUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset("assets${model.partData.loopImgUrl[index]}",
              width: double.infinity, height: 400, fit: BoxFit.fill);
        },
      ),
    );
  }
}
