import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
<<<<<<< HEAD
              color: Color(0xFFf4f4f4),
              child: Consumer<HomePageProvider>(builder: (_, provider, __) {
                // print(provider.isLoading);
                // 加载动画
                if (provider.isLoading) {
                  return Center(child: CupertinoActivityIndicator());
                }

                // 捕获异常
                if (provider.isError) {
                  return Center(
                    child: Column(
=======
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
>>>>>>> lesson-10
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
<<<<<<< HEAD
                    ),
                  );
                }

                return Container();
              }),
=======
                    ));
                  }

                  HomePageModel model = provider.model;
                  print(model.toJson());

                  return ListView(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 72 / 35,
                        child: Swiper(
                          itemCount: model.swipers.length,
                          pagination: SwiperPagination(),
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            //assets/image/jd1.jpg
                            return Image.asset(
                                "assets${model.swipers[index].image}");
                          },
                        ),
                      )
                    ],
                  );
                  // return Container();
                },
              ),
>>>>>>> lesson-10
            )));
  }
}

// NetRequest() async {
//   var dio = Dio();
//   Response response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
