import 'package:flash_employee/ui/splash/app_splash.dart';
import 'package:flash_employee/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flash Employee',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppSplash(),
      );
    }
    );
  }
}