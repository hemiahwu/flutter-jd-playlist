import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/net/net_request.dart';
import 'package:jd_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

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
            body: Consumer<HomePageProvider>(builder: (_, provider, __) {
              return Container();
            })));
  }
}

// NetRequest() async {
//   var dio = Dio();
//   Response response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
