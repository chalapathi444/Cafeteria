import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class IsAdmin extends ChangeNotifier {
  bool _isAdmin = false;
  String _userId;
  get userId {
    return _userId;
  }

  get isAdmin {
    return _isAdmin;
  }

  void change_to_admin() {
    _isAdmin = true;
    notifyListeners();
  }

  void assign(String a) {
    _userId = a;
  }

  void chagne_to_user() {
    _isAdmin = false;
    notifyListeners();
  }
}
