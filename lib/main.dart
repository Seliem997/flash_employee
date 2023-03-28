import 'package:flash_employee/providers/user_provider.dart';
import 'package:flash_employee/ui/splash/app_splash.dart';
import 'package:flash_employee/utils/cache_helper.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flash_employee/utils/enum/shared_preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  static void changeThemeMode(BuildContext context) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeThemeMode();
  }

  static bool themeMode(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    return state.isDarkMode;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void changeThemeMode() {
    isDarkMode = !isDarkMode;
    setState(() {});
    if (isDarkMode) {
      CacheHelper.saveData(key: CacheKey.darkMode, value: true);
    } else {
      CacheHelper.saveData(key: CacheKey.darkMode, value: false);
    }
  }

  @override
  void initState() {
    if (CacheHelper.returnData(key: CacheKey.darkMode) != null) {
      isDarkMode = CacheHelper.returnData(key: CacheKey.darkMode);
    }
    super.initState();
  }

  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColor.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        isDarkMode ? true : false);
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
            theme: isDarkMode
                ? ThemeData.dark().copyWith(
                    // primarySwatch: Colors.blue,
                    appBarTheme: AppBarTheme(color: AppColor.darkScaffoldColor),
                    scaffoldBackgroundColor: AppColor.darkScaffoldColor)
                : ThemeData(
                    primarySwatch: Colors.blue,
                    appBarTheme: AppBarTheme(color: AppColor.white),
                    scaffoldBackgroundColor: AppColor.lightScaffoldColor),
            home: const AppSplash(),
          );
        }));
  }
}
