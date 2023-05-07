import 'package:flash_employee/models/incomesModel.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';

class IncomeItem extends StatelessWidget {
  final IncomeData income;
  const IncomeItem({
    Key? key,
    required this.income,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        // navigateTo(context, IncomeDetailsScreen());
      },
      width: 345,
      radiusCircular: 6,
      backgroundColor: AppColor.incomeColor,
      padding: symmetricEdgeInsets(vertical: 13, horizontal: 13),
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
    );
  }
}
