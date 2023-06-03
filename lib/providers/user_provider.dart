import 'package:flash_employee/services/authentication_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../models/loginModel.dart';
import '../ui/widgets/app_loader.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/shared_preference_keys.dart';

class UserProvider extends ChangeNotifier {
  final AuthenticationService authenticationService = AuthenticationService();
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

  Future<void> updatePhoneNumber(
      BuildContext context, String phoneNumber) async {
    AppLoader.showLoader(context);

    await authenticationService.updatePhoneNumber(phoneNumber).then((value) {
      AppLoader.stopLoader();
      if (value.status == Status.success) {
        phone = phoneNumber;
        CustomSnackBars.successSnackBar(context, "Updated Successfully");
        CacheHelper.saveData(key: CacheKey.phoneNumber, value: phoneNumber);
      } else {
        CustomSnackBars.failureSnackBar(context, "Something went wrong");
      }
      Navigator.pop(context);
    });
  }

  Future<void> updateProfilePicture(BuildContext context, XFile image) async {
    AppLoader.showLoader(context);

    await authenticationService.updateProfilePicture(image).then((value) {
      AppLoader.stopLoader();
      if (value.status == Status.success) {
        CustomSnackBars.successSnackBar(context, "Updated Successfully");
        userImage = value.data;
        CacheHelper.saveData(key: CacheKey.userImage, value: value.data);
      } else {
        CustomSnackBars.failureSnackBar(context, "Something went wrong");
      }
    });
  }
}
