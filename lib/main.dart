import 'package:flutter/material.dart';
import 'package:jd_app/WeatherInfo.dart';
// 1
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Provider Pattern"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MySpecialHeading(),
              MySpecialContent(),
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(),
      ),
    );
  }
}

class MySpecialHeading extends StatelessWidget {
  const MySpecialHeading({Key key}) : super(key: key);
  Color decideColor(WeatherInfo info) {
    return info.temperatureType == "摄氏度" ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    var weatherInfo = Provider.of<WeatherInfo>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        weatherInfo.temperatureType,
        style: TextStyle(
          color: decideColor(weatherInfo),
          fontSize: 26.0,
        ),
      ),
    );
  }
}

class MySpecialContent extends StatelessWidget {
  const MySpecialContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: Text("温度"));
    // child: Consumer<WeatherInfo>(
    //   builder: (context, weatherInfo, _) => Text(
    //     weatherInfo.temperatureType,
    //     style: TextStyle(
    //       color: Colors.deepPurple,
    //       fontSize: 26.0,
    //     ),
    //   ),
    // ));
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({Key key}) : super(key: key);

  Color decideColor(WeatherInfo info) {
    return info.temperatureType == "摄氏度" ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    var weatherInfo = Provider.of<WeatherInfo>(context);

    return FloatingActionButton(
      backgroundColor: decideColor(weatherInfo),
      onPressed: () {
        // TODO: some event
        String newWeatherType =
            weatherInfo.temperatureType == "摄氏度" ? "华氏度" : "摄氏度";
        weatherInfo.temperatureType = newWeatherType;
      },
      tooltip: "改变温度类型",
      child: Text(weatherInfo.temperatureType),
    );
  }
}
