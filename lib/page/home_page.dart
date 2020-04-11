import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/home_page_model.dart';
import '../model/home_page_model.dart';

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
                  print(model.toJson());

                  return ListView(
                    children: <Widget>[
                      buildAspectRatio(model),

                      // 图标分类
                      buildLogos(model),

                      // 掌上秒杀的头部
                    ],
                  );
                  // return Container();
                },
              ),
            )));
  }

  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          //assets/image/jd1.jpg
          return Image.asset("assets${model.swipers[index].image}");
        },
      ),
    );
  }

  // logos方法
  Widget buildLogos(HomePageModel model) {
    List<Widget> list = List<Widget>();

    for (var i = 0; i < model.logos.length; i++) {
      list.add(Container(
        width: 60.0,
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets${model.logos[i].image}",
              width: 50,
              height: 50,
            ),
            Text("${model.logos[i].title}"),
          ],
        ),
      ));
    }
    return Container(
        color: Colors.white,
        height: 170,
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.spaceBetween,
          children: list,
        ));
  }
}

// NetRequest() async {
//   var dio = Dio();
//   Response response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
