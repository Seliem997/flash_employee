import 'package:flutter/cupertino.dart';

import '../models/loginModel.dart';

class UserProvider extends ChangeNotifier {
  String? _userName;
  String? _userImage;
  String? _phone;
  int _selectedTap = 1;

  int get selectedTap => _selectedTap;

  set selectedTap(int value) {
    _selectedTap = value;
    notifyListeners();
  }

  String? get userName => _userName;

  set userName(String? value) {
    _userName = value;
    notifyListeners();
  }

  String? email;
  List<Duties>? duties;

  String? get userImage => _userImage;

  set userImage(String? value) {
    _userImage = value;
    notifyListeners();
  }

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }
}
