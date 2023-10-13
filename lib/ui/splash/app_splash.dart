import 'package:flash_employee/models/loginModel.dart';
import 'package:flash_employee/ui/home/home_screen.dart';
import 'package:flash_employee/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/authentication_service.dart';
import '../../utils/cache_helper.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../../utils/enum/statuses.dart';
import '../income/income_screen.dart';
import '../inventory/inventory_screen.dart';
import '../user/login/login.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({Key? key}) : super(key: key);

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    _controller = GifController(vsync: this);
    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {});
      }
    });
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
          navigateAndFinish(context, const LoginScreen());
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
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controller.isCompleted
                  ? CustomContainer(
                      height: 180,
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png')))
                  : Gif(
                      height: 400,
                      image:
                          const AssetImage('assets/images/logo_animation.gif'),
                      controller:
                          _controller, // if duration and fps is null, original gif fps will be used.
                      autostart: Autostart.once,
                    ),
              verticalSpace(20),
              Visibility(
                visible: _controller.isCompleted,
                child: Container(
                  height: 20,
                  width: 20,
                  child: const DataLoader(useExpand: false),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
