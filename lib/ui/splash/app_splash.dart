import 'package:flash_employee/models/loginModel.dart';
import 'package:flash_employee/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/authentication_service.dart';
import '../../utils/cache_helper.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../../utils/enum/statuses.dart';
import '../user/login/login.dart';
import '../widgets/custom_container.dart';
import '../widgets/navigate.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({Key? key}) : super(key: key);

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    if (CacheHelper.returnData(key: CacheKey.loggedIn)) {
      final UserProvider userDataProvider =
          Provider.of<UserProvider>(context, listen: false);
      AuthenticationService authenticationService = AuthenticationService();
      await authenticationService.getMyProfile().then((result) {
        if (result.status == Status.success) {
          final userData = (result.data as UserData?);
          if ((result.data as UserData?) != null) {
            userDataProvider.phone = userData!.phone;
            userDataProvider.userName = userData.name;
            userDataProvider.userImage = userData.image;
            userDataProvider.email = userData.email;
            userDataProvider.duties = userData.duties;
          }
        } else {
          authenticationService.signOut();
        }
      });
    }
    await Future.delayed(const Duration(seconds: 3));
    final bool loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
    navigateAndFinish(
      context,
      !loggedIn ? const LoginScreen() : const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomSizedBox(
            // width: 279,
            // height: 258,
            child: Image.asset('assets/images/logo_animation.gif')),
      ),
    );
  }
}
