import 'package:code_gen/sci_route.dart';
import 'package:flutter/material.dart';

@SciRedirectedRoute(url: "/notFoundPage?title=404")
class NotFoundPage extends StatelessWidget {
  final Map arg;
  NotFoundPage(this.arg);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arg["title"]),
      ),
      body: Center(
        child: Text(arg["title"]),
      ),
    );
  }
}
