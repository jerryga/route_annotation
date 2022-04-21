import 'package:code_gen/sci_route.dart';
import 'package:flutter/material.dart';

@SciRoute(url: "/PageA")

class PageA extends StatelessWidget{
  final Map arg;
  PageA(this.arg);


  @SciFunction()
  void PPPPPPPPP(dynamic fromWidget) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageA"),
      ),
      body: Center(
        child: Text("arg: $arg"),
      ),
    );
  }
}