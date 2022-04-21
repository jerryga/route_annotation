import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _authenticated = false;

  bool get authenticated => _authenticated;

  changeAuthState(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}
