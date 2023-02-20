import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../home/home_screen.dart';
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
    await Future.delayed(const Duration(seconds: 4));
    navigateAndFinish(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomSizedBox(
          width: 279,
            height: 258,
            child: Image.asset('assets/images/logo.png')),
      ),
    );
  }
}
