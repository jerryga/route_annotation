import 'package:code_gen/sci_route.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/main.dart';

@SciRoute(url: "/loginPage")
class LoginPage extends StatelessWidget {
  final Object arg;
  LoginPage(this.arg);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child:   ElevatedButton(
          child: Text("Login"),
          onPressed: () {
            authService.changeAuthState(true);
          },
        ),
      ),
    );
  }
}
