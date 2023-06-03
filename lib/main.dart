import 'package:firebase_core/firebase_core.dart';
import 'package:flash_employee/providers/contact_us_provider.dart';
import 'package:flash_employee/providers/income_provider.dart';
import 'package:flash_employee/providers/inventory_provider.dart';
import 'package:flash_employee/providers/invoices_provider.dart';
import 'package:flash_employee/providers/requests_provider.dart';
import 'package:flash_employee/providers/transactions_provider.dart';
import 'package:flash_employee/providers/user_provider.dart';
import 'package:flash_employee/services/firebase_service.dart';
import 'package:flash_employee/ui/splash/app_splash.dart';
import 'package:flash_employee/utils/cache_helper.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flash_employee/utils/enum/shared_preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService.initializeFirebase();
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
  FToast fToast = FToast();
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
    fToast.init(context);
    if (CacheHelper.returnData(key: CacheKey.darkMode) != null) {
      isDarkMode = CacheHelper.returnData(key: CacheKey.darkMode);
    }
    super.initState();
  }

  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en', null);
    FlutterStatusbarcolor.setStatusBarColor(AppColor.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        isDarkMode ? true : false);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => InvoicesProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => InventoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TransactionsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RequestsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => IncomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ContactUsProvider(),
          )
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: FToastBuilder(),
            title: 'Flash Employee',
            theme: isDarkMode
                ? ThemeData.dark().copyWith(
                    // primarySwatch: Colors.blue,
                    appBarTheme: const AppBarTheme(
                        color: AppColor.darkScaffoldColor,
                        iconTheme: IconThemeData(color: Colors.white)),
                    scaffoldBackgroundColor: AppColor.darkScaffoldColor)
                : ThemeData(
                    primarySwatch: Colors.blue,
                    appBarTheme: const AppBarTheme(
                        color: AppColor.white,
                        iconTheme: IconThemeData(color: Colors.black)),
                    scaffoldBackgroundColor: AppColor.lightScaffoldColor),
            home: const AppSplash(),
          );
        }));
  }
}
