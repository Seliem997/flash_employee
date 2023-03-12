import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();

    return Scaffold(
      // backgroundColor: Colors.white,
      key: globalKey,
      body: Padding(
        padding: onlyEdgeInsets(top: 68, start: 24, end: 24),
        child: Column(
          children: [
            buildHeader(
                context: context,
                onTap: () {
                  globalKey.currentState!.openDrawer();
                }),
            verticalSpace(24),
            DefaultFormField(
              hintText:
                  'Search for request by Request ID / Customer ID / Mobile',
              hintStyle: TextStyle(
                fontWeight: MyFontWeight.medium,
                fontSize: MyFontSize.size12,
                color: const Color(0xFF949494),
              ),
              filled: true,
              fillColor: AppColor.babyBlue,
              icon: SvgPicture.asset('assets/svg/search.svg'),
            ),
            verticalSpace(15),
            Row(
              children: [
                DefaultButtonWithIcon(
                  padding: symmetricEdgeInsets(horizontal: 10),
                  icon: SvgPicture.asset('assets/svg/filter.svg'),
                  onPressed: () {},
                  labelText: 'Status type',
                  textColor: AppColor.filterGrey,
                  backgroundButton: const Color(0xFFF0F0F0),
                  borderColor: AppColor.filterGrey,
                  border: true,
                ),
                const Spacer(),
                DefaultButtonWithIcon(
                  padding: symmetricEdgeInsets(horizontal: 10),
                  icon: SvgPicture.asset('assets/svg/filter.svg'),
                  onPressed: () {},
                  labelText: 'Date filter',
                  textColor: AppColor.filterGrey,
                  backgroundButton: const Color(0xFFF0F0F0),
                  borderColor: AppColor.filterGrey,
                  border: true,
                ),
              ],
            ),
            verticalSpace(15),
            CustomContainer(
              onTap: () {
                navigateTo(context, RequestDetailsScreen());
              },
              width: 345,
              height: 118,
              radiusCircular: 6,
              backgroundColor: AppColor.borderGray,
              padding: symmetricEdgeInsets(vertical: 13, horizontal: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              text: 'Request ID : ',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: 'FLASH4584',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        Row(
                          children: [
                            TextWidget(
                              text: 'Type of Service : ',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: 'Wash',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/alarm.svg'),
                            horizontalSpace(15),
                            TextWidget(
                              text: '03:15 PM',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 12,
                              color: Color(0xff616161),
                            ),
                            horizontalSpace(15),
                            TextWidget(
                              text: 'Monday, 23 January 2023',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      DefaultButton(
                        height: 21,
                        padding: EdgeInsets.zero,
                        width: 64,
                        text: 'On the way',
                        fontSize: MyFontSize.size9,
                        fontWeight: MyFontWeight.semiBold,
                        backgroundColor: AppColor.onTheWayButton,
                        onPressed: () {},
                      ),
                      Spacer(),
                      Icon(
                        Icons.location_on_outlined,
                        size: 35,
                      ),
                      TextWidget(
                        text: '2 Km',
                        fontWeight: MyFontWeight.bold,
                        textSize: MyFontSize.size9,
                      ),
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(15),
            CustomContainer(
              onTap: () {
                navigateTo(context, RequestDetailsScreen());
              },
              width: 345,
              height: 118,
              radiusCircular: 6,
              backgroundColor: AppColor.borderGray,
              padding: symmetricEdgeInsets(vertical: 13, horizontal: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              text: 'Request ID : ',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: 'FLASH4584',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        Row(
                          children: [
                            TextWidget(
                              text: 'Type of Service : ',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: 'Wash',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/alarm.svg'),
                            horizontalSpace(15),
                            TextWidget(
                              text: '03:15 PM',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 12,
                              color: Color(0xff616161),
                            ),
                            horizontalSpace(15),
                            TextWidget(
                              text: 'Monday, 23 January 2023',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: AppColor.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      DefaultButton(
                        height: 21,
                        padding: EdgeInsets.zero,
                        width: 64,
                        text: 'Pending',
                        fontSize: MyFontSize.size9,
                        fontWeight: MyFontWeight.semiBold,
                        backgroundColor: AppColor.pendingButton,
                        onPressed: () {},
                      ),
                      Spacer(),
                      Icon(
                        Icons.location_on_outlined,
                        size: 35,
                      ),
                      TextWidget(
                        text: '1.5 Km',
                        fontWeight: MyFontWeight.bold,
                        textSize: MyFontSize.size9,
                      ),
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(15),
          ],
        ),
      ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }

  Row buildHeader({required BuildContext context, onTap}) {
    return Row(
      children: [
        CustomSizedBox(
          width: 24,
          height: 24,
          onTap: onTap,
          child: SvgPicture.asset('assets/svg/menu.svg'),
        ),
        horizontalSpace(12),
        TextWidget(
          text: 'Hi, Mahmoud Ali',
          fontWeight: MyFontWeight.semiBold,
          textSize: MyFontSize.size14,
          color: const Color(0xFF292D32),
        ),
      ],
    );
  }
}
