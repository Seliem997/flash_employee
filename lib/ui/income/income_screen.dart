import 'package:flash_employee/ui/income/income_details/income_details_screen.dart';
import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      key: globalKey,
      appBar: AppBar(
        title: const TextWidget(
          text: "Income",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: symmetricEdgeInsets(vertical: 15, horizontal: 24),
            child: Column(
              children: [
                DefaultFormField(
                  hintText: 'ID Search',
                  hintStyle: TextStyle(
                    fontWeight: MyFontWeight.medium,
                    fontSize: 14,
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
                      labelText: 'Payment type',
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
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      CustomContainer(
                        onTap: () {
                          navigateTo(context, IncomeDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.incomeColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Request ID : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'FLASH154841965',
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Other services',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(12),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Payment method : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Cash',
                                        textSize: 14,
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
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Export Pdf.png',
                                  height: 42,
                                  width: 42,
                                ),
                                verticalSpace(10),
                                TextWidget(
                                  text: '75 SR',
                                  fontWeight: MyFontWeight.bold,
                                  textSize: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      verticalSpace(15),
                      CustomContainer(
                        onTap: () {
                          navigateTo(context, IncomeDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.incomeColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Request ID : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'FLASH154841965',
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Other services',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(12),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Payment method : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Cash',
                                        textSize: 14,
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
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Export Pdf.png',
                                  height: 42,
                                  width: 42,
                                ),
                                verticalSpace(10),
                                TextWidget(
                                  text: '55 SR',
                                  fontWeight: MyFontWeight.bold,
                                  textSize: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      verticalSpace(15),
                      CustomContainer(
                        onTap: () {
                          navigateTo(context, IncomeDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.incomeColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Request ID : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'FLASH154841965',
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Other services',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(12),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Payment method : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Cash',
                                        textSize: 14,
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
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Export Pdf.png',
                                  height: 42,
                                  width: 42,
                                ),
                                verticalSpace(10),
                                TextWidget(
                                  text: '85 SR',
                                  fontWeight: MyFontWeight.bold,
                                  textSize: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      verticalSpace(15),
                      CustomContainer(
                        onTap: () {
                          navigateTo(context, IncomeDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.incomeColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Request ID : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'FLASH154841965',
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Other services',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(12),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Payment method : ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                      TextWidget(
                                        text: 'Cash',
                                        textSize: 14,
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
                                        textSize: 14,
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
                                        textSize: 14,
                                        fontWeight: MyFontWeight.medium,
                                        color: AppColor.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Export Pdf.png',
                                  height: 42,
                                  width: 42,
                                ),
                                verticalSpace(10),
                                TextWidget(
                                  text: '50 SR',
                                  fontWeight: MyFontWeight.bold,
                                  textSize: 18,
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
                verticalSpace(200)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomContainer(
              width: double.infinity,
              height: 215,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32), topLeft: Radius.circular(32)),
              backgroundColor: Color(0xffC7E4F8),
              padding: symmetricEdgeInsets(horizontal: 20, vertical: 15),
              borderColor: AppColor.primary,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Cash : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '25 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Mada machine : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '200 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Mada gateway : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '200 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Wallet : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '0 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.pendingButton,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Total invoices : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                                color: AppColor.pendingButton,
                              ),
                              TextWidget(
                                text: '0 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.pendingButton,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'STC Pay : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '25 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Apple Pay : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '195 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Bank transfer : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '64 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Total left : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                                color: Color(0xff008A0E),
                              ),
                              TextWidget(
                                text: '25 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: Color(0xff008A0E),
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Total cash left : ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                                color: Color(0xff011BA3),
                              ),
                              TextWidget(
                                text: '25 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.medium,
                                color: Color(0xff011BA3),
                              ),
                            ],
                          ),
                          verticalSpace(12),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomContainer(
                        height: 22,
                        width: 22,
                        padding: EdgeInsets.zero,
                        radiusCircular: 0,
                        backgroundColor: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage("assets/images/share.png"),
                            fit: BoxFit.fitHeight),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Total :  ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '287.50 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/Export Pdf.png',
                        height: 42,
                        width: 42,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }
}
