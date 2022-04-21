import 'package:flutter/material.dart';
import 'package:helloworld/route/approute.route.dart';

import 'guard/auth_service.dart';

final authService = AuthService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("正常跳转"),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AppRoute().getPage("/PageA?id=10000")),
                );
              },
            ),
            ElevatedButton(
              child: Text("带参数跳转"),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AppRoute().getPage("/PageC?pageID=120309&detail=hello")),
                );
              },
            ),
            ElevatedButton(
              child: Text("拦截跳转"),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AppRoute().getPage("/PageB?user_name=CS")),
                );
              },
            ),
            ElevatedButton(
              child: Text("跳转【不存在的】页面"),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AppRoute().getPage("/PageD")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
