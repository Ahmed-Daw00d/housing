import 'package:flutter/material.dart';
import 'package:housing/models/user.dart';
import 'package:housing/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  final AuthMethod _authMethod = AuthMethod();

  User get getUser => _user!;

  Future<void> refreeshUser() async {
    User user = await _authMethod.getUserDetials();
    _user = user;
    notifyListeners();
  }
}
