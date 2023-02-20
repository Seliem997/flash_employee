import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
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
      height: 170,
      padding: onlyEdgeInsets(top: 32, bottom: 16, start: 24, end: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          verticalSpace(12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Profile Name',
                    color: AppColor.black,
                    fontWeight: MyFontWeight.semiBold,
                    textSize: MyFontSize.size15,
                  ),
                  verticalSpace(6),
                  TextWidget(
                    text: '01234567890',
                    color: const Color(0xff1E1E1E),
                    fontWeight: MyFontWeight.regular,
                    textSize: MyFontSize.size9,
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
      padding: symmetricEdgeInsets(horizontal: 40,vertical: 58),
      child: Column(
        children: [
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/profile.svg',
                color: AppColor.grey,
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Profile',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/home_light.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Home',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/wallet.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Income',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/invoices.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Invoices',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/inventory.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Inventory',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/calendar.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Duty',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CustomSizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/svg/messages.svg',
              ),
            ),
            minLeadingWidth: 2.w,
            title: TextWidget(
              text: 'Contact us',
              color: AppColor.grey,
              textSize: MyFontSize.size16,
              fontWeight: MyFontWeight.medium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
