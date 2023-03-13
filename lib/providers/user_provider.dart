import 'package:flutter/cupertino.dart';

import '../models/loginModel.dart';

class UserProvider extends ChangeNotifier {
  String? userName;
  String? userImage;
  String? phone;
  String? email;
  List<Duties>? duties;
}
