import 'package:code_gen/sci_route.dart';
import 'package:flutter/material.dart';

@SciRoute(url: "/PageC")
class PageC extends StatelessWidget{
  final Object arg;
  PageC(this.arg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageC"),
      ),
      body: Center(
        child: Text("arg: $arg"),
      ),
    );
  }
}