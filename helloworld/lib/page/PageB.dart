import 'package:code_gen/sci_route.dart';
import 'package:flutter/material.dart';

@SciRoute(url: "/PageB", guard_name: "checkLogin")
class PageB extends StatelessWidget{
  final Map arg;
  PageB(this.arg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageB"),
      ),
      body: Center(
        child: Text("arg: $arg"),
      ),
    );
  }
}