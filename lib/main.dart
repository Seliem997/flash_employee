import 'package:flash_employee/providers/user_provider.dart';
import 'package:flash_employee/ui/splash/app_splash.dart';
import 'package:flash_employee/utils/cache_helper.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColor.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          )
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flash Employee',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white),
            home: const AppSplash(),
          );
        }));
  }
}
