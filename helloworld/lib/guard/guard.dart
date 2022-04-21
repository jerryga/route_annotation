
import 'package:code_gen/sci_route.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/main.dart';
import 'package:helloworld/route/approute.route.dart';


@SciFunction()
dynamic checkLogin(dynamic fromWidget) {

  if (authService.authenticated) {
    return fromWidget;
  }else {
    GuardManager().updateCurrentWidget(fromWidget);
    return AppRoute().getPage('/loginPage');
  }
}

class GuardManager {
  static final GuardManager _manager = GuardManager._internal();
  static Widget? _fromWidget;
  static Widget? _lastWidget;

  void updateCurrentWidget(Widget widget) {
    if (widget is Widget) {
        _fromWidget = widget;
    }
  }

  factory GuardManager() {
    authService.addListener(() {
      if (_fromWidget != null && authService.authenticated && false == identical(_fromWidget, _lastWidget) ) {
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (context) => _fromWidget!));
        _lastWidget = _fromWidget;
      }
    });
    return _manager;
  }
  GuardManager._internal();
}
