import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/home_page_model.dart';
import 'package:jd_app/net/net_request.dart';
import 'package:jd_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // NetRequest();
    // NetRequest().reqeustData(JdApi.HOME_PAGE).then((res) => print(res.data));

    return ChangeNotifierProvider<HomePageProvider>(
        create: (context) {
          var provider = new HomePageProvider();
          provider.loadHomePageData();
          return provider;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("首页"),
            ),
            body: Container(
              color: Color(0xFFf7f7f7),
              child: Consumer<HomePageProvider>(
                builder: (_, provider, __) {
                  print(provider.isLoading);
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
                            provider.loadHomePageData();
                          },
                        )
                      ],
                    ));
                  }

                  HomePageModel model = provider.model;
                  print(model.swipers.length);
                  return ListView(
                    children: <Widget>[
                      // 轮播图
                      AspectRatio(
                        aspectRatio: 72 / 35,
                        child: Swiper(
                          itemCount: model.swipers.length,
                          pagination: SwiperPagination(),
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.asset(
                                "assets${model.swipers[index].image}");
                          },
                        ),
                      ),
                      // 图标分类
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        color: Colors.white,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/image/bej.png",
                              width: 90,
                              height: 20,
                            ),
                            Spacer(),
                            Text("更多秒杀"),
                            Icon(CupertinoIcons.right_chevron, size: 14)
                          ],
                        ),
                      ),
                      // 掌上秒杀的横向列表
                      Container(
                          height: 120,
                          color: Colors.white,
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets${model.quicks[index].image}",
                                    width: 85,
                                    height: 85,
                                  ),
                                  Text(
                                    "${model.quicks[index].price}",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16.0),
                                  )
                                ],
                              ),
                            );
                          })),
                    ],
                  );
                  // return Container();
                },
              ),
            )));
  }
}

// NetRequest() async {
//   var dio = Dio();
//   Response response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
