import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_employee/main.dart';
import 'package:flash_employee/ui/duty/duty_screen.dart';
import 'package:flash_employee/ui/income/income_screen.dart';
import 'package:flash_employee/ui/inventory/inventory_screen.dart';
import 'package:flash_employee/ui/profile/profile_screen.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sizer/sizer.dart';

import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../contact_us/contact_us_screen.dart';
import '../invoices/invoices_screen.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';
import 'logout_dialog.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(userDataProvider),
            buildMenuItems(context, userDataProvider),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(UserProvider userDataProvider) {
    return CustomContainer(
      backgroundColor:
          MyApp.themeMode(context) ? Color(0xFF3C1E70) : AppColor.babyBlue,
      width: 272,
      height: 175,
      padding: onlyEdgeInsets(top: 32, bottom: 16, start: 24, end: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: CachedNetworkImageProvider(userDataProvider
                    .userImage ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0F6JSOHkKNsDAnJo3mBl98s0JXJ4dheYY-0jWCUjFJ0tiW6VyPfLJ_wQP&s=10"),
          ),
          verticalSpace(12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: userDataProvider.userName ?? "No Name",
                    color: AppColor.black,
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size15,
                  ),
                  verticalSpace(6),
                  TextWidget(
                    text: userDataProvider.phone ?? '01234567890',
                    color: const Color(0xff1E1E1E),
                    fontWeight: MyFontWeight.regular,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
              // const Spacer(),
              // SvgPicture.asset('assets/svg/translate.svg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context, UserProvider userDataProvider) {
    return Padding(
      padding: symmetricEdgeInsets(horizontal: 30, vertical: 42),
      child: Column(
        children: [
          ListTile(
            selected: userDataProvider.selectedTap == 0,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/profile.svg',
                color: userDataProvider.selectedTap == 0
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Profile',
              color: userDataProvider.selectedTap == 0
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 0;
              navigateTo(context, ProfileScreen());
              // Navigator.pop(context);
            },
          ),
          ListTile(
            selected: userDataProvider.selectedTap == 1,
            minVerticalPadding: 0,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/home_light.svg',
                color: userDataProvider.selectedTap == 1
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : null,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Home',
              color: userDataProvider.selectedTap == 1
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 1;

              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: userDataProvider.selectedTap == 2,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/wallet.svg',
                color: userDataProvider.selectedTap == 2
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : null,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Income',
              color: userDataProvider.selectedTap == 2
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 2;

              navigateTo(context, IncomeScreen());
            },
          ),
          ListTile(
            selected: userDataProvider.selectedTap == 3,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/invoices.svg',
                color: userDataProvider.selectedTap == 3
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : null,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Invoices',
              color: userDataProvider.selectedTap == 3
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 3;

              navigateTo(context, InvoicesScreen());
            },
          ),
          ListTile(
            selected: userDataProvider.selectedTap == 4,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/inventory.svg',
                color: userDataProvider.selectedTap == 4
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : null,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Inventory',
              color: userDataProvider.selectedTap == 4
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 4;

              navigateTo(context, InventoryScreen());
            },
          ),
          ListTile(
            selected: userDataProvider.selectedTap == 5,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/calendar.svg',
                color: userDataProvider.selectedTap == 5
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : null,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Duty',
              color: userDataProvider.selectedTap == 5
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 5;

              navigateTo(context, DutyScreen());
              // Navigator.pop(context);
            },
          ),
          ListTile(
            selected: userDataProvider.selectedTap == 6,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/messages.svg',
                color: userDataProvider.selectedTap == 6
                    ? Color(0xff097AC9)
                    : MyApp.themeMode(context)
                        ? Colors.white
                        : null,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Contact us',
              color: userDataProvider.selectedTap == 6
                  ? Color(0xff097AC9)
                  : AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              userDataProvider.selectedTap = 6;
              navigateTo(context, ContactUsScreen());
            },
          ),
          ListTile(
            minLeadingWidth: 2.w,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlutterSwitch(
                  width: 80.0,
                  height: 40.0,
                  toggleSize: 25.0,
                  value: MyApp.themeMode(context),
                  borderRadius: 25.0,
                  padding: 2.0,
                  activeToggleColor: Color(0xFF6E40C9),
                  inactiveToggleColor: Color(0xFF2F363D),
                  activeSwitchBorder: Border.all(
                    color: Color(0xFF3C1E70),
                    width: 6.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: Color(0xFFD1D5DA),
                    width: 6.0,
                  ),
                  activeColor: Color(0xFF271052),
                  inactiveColor: Colors.white,
                  activeIcon: Icon(
                    Icons.nightlight_round,
                    color: Color(0xFFF8E3A1),
                  ),
                  inactiveIcon: Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFFDF5D),
                  ),
                  onToggle: (val) {
                    MyApp.changeThemeMode(context);
                    setState(() {});
                    Restart.restartApp();
                  },
                ),
              ],
            ),
          ),
          verticalSpace(60),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/logout.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: "Log out",
              color: Color(0xFFCC4A50),
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const LogOutDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
