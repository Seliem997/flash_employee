import 'package:flash_employee/ui/duty/duty_screen.dart';
import 'package:flash_employee/ui/profile/profile_screen.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../contact_us/contact_us_screen.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return CustomContainer(
      backgroundColor: AppColor.babyBlue,
      width: 272,
      height: 175,
      padding: onlyEdgeInsets(top: 32, bottom: 16, start: 24, end: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          verticalSpace(12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Mahmoud Ali',
                    color: AppColor.black,
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size15,
                  ),
                  verticalSpace(6),
                  TextWidget(
                    text: '01234567890',
                    color: const Color(0xff1E1E1E),
                    fontWeight: MyFontWeight.regular,
                    textSize: MyFontSize.size12,
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset('assets/svg/translate.svg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Padding(
      padding: symmetricEdgeInsets(horizontal: 30, vertical: 42),
      child: Column(
        children: [
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/profile.svg',
                color: AppColor.grey,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Profile',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              // navigateTo(context, ProfileScreen());
              // Navigator.pop(context);
            },
          ),
          ListTile(
            selected: true,
            minVerticalPadding: 0,
            selectedTileColor: AppColor.primary.withOpacity(.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/home_light.svg',
                color: Color(0xff097AC9),
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Home',
              color: Color(0xff097AC9),
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/wallet.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Income',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/invoices.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Invoices',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/inventory.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Inventory',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/calendar.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Duty',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              navigateTo(context, DutyScreen());
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/svg/messages.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Contact us',
              color: AppColor.grey,
              textSize: 18,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              navigateTo(context, ContactUsScreen());
            },
          ),
        ],
      ),
    );
  }
}
