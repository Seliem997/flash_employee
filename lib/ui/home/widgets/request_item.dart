import 'package:change_case/change_case.dart';
import 'package:flash_employee/main.dart';
import 'package:flash_employee/models/requestsModel.dart';
import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/enum/status_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../providers/requests_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';

class RequestItem extends StatelessWidget {
  final RequestData request;

  const RequestItem({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);
    return CustomContainer(
      onTap: () async {
        requestsProvider.selectedRequestId = request.id.toString();
        navigateTo(context, const RequestDetailsScreen());
      },
      width: 345,
      height: 210,
      radiusCircular: 6,
      borderColor: MyApp.themeMode(context) ? Colors.grey : null,
      backgroundColor: MyApp.themeMode(context) ? null : AppColor.borderGray,
      padding: symmetricEdgeInsets(vertical: 13, horizontal: 13),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(
                      text: 'Request ID : ',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                    TextWidget(
                      text: '${request.requestId}',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      color: AppColor.grey,
                    ),
                  ],
                ),
                verticalSpace(12),
                Row(
                  children: [
                    TextWidget(
                      text: 'Client Name : ',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                    TextWidget(
                      text: '${request.customer!.name == null || request.customer!.name == '' ? 'Customer' : request.customer!.name}',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      color: AppColor.grey,
                    ),
                  ],
                ),
                verticalSpace(12),
                Row(
                  children: [
                    TextWidget(
                      text: 'Client number : ',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                    TextWidget(
                      text: '${request.customer!.phone}',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      color: AppColor.grey,
                    ),
                  ],
                ),
                verticalSpace(12),
                Column(
                  children: [
                    TextWidget(
                      text: 'Type of Service : ',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.semiBold,
                    ),
                    verticalSpace(10),
                    TextWidget(
                      text: request.services !=null
                          ? request.services!.isNotEmpty ? '${request.services![0].title}' : 'Monthly Package'
                          : 'Monthly Package',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      color: AppColor.grey,
                    ),
                  ],
                ),
                verticalSpace(12),
                request.status != StatusType.canceled.key
                    ? Row(
                  children: [
                    SvgPicture.asset('assets/svg/alarm.svg'),
                    horizontalSpace(8),
                    TextWidget(
                      text: request.slots !=null
                          ? request.slots!.isNotEmpty ? '${request.slots![0].startAt}' : '${request.time}'
                          : '${request.time}',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      color: AppColor.grey,
                    ),
                  ],
                )
                    : const SizedBox(),
                verticalSpace(10),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xff616161),
                    ),
                    horizontalSpace(8),
                    TextWidget(
                      text: '${request.slotsDate}',
                      textSize: 12.8,
                      fontWeight: MyFontWeight.medium,
                      color: AppColor.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefaultButton(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                text: "${request.status}",
                fontSize: MyFontSize.size9,
                fontWeight: MyFontWeight.semiBold,
                backgroundColor: request.status == StatusType.completed.key
                    ? Colors.green
                    : request.status == StatusType.pending.key
                    ? Colors.orange
                    : request.status == StatusType.arrived.key ||  request.status == StatusType.onTheWay.key
                    ? Colors.yellow
                    : request.status == StatusType.canceled.key
                    ? Colors.red
                    : AppColor.textRed,
                textColor: Colors.black,
                onPressed: () {},
              ),
              const Spacer(),
              TextWidget(
                text: '(Total)',
                fontWeight: MyFontWeight.bold,
                textSize: MyFontSize.size15,

              ),
              verticalSpace(12),
              TextWidget(
                text: '${request.totalAmount}',
                fontWeight: MyFontWeight.bold,
                textSize: MyFontSize.size14,

              ),
            ],
          )
        ],
      ),
    );
  }
}
