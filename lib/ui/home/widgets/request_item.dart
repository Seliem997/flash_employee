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
        navigateTo(context, RequestDetailsScreen());
      },
      width: 345,
      height: 118,
      radiusCircular: 6,
      borderColor: MyApp.themeMode(context) ? Colors.grey : null,
      backgroundColor: MyApp.themeMode(context) ? null : AppColor.borderGray,
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
                      text: '${request.id}',
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
                      text: '${request.services![0].title}',
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
                      text: '${request.time}',
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
                      text: '${request.date}',
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
                text: "${request.status}",
                fontSize: MyFontSize.size9,
                fontWeight: MyFontWeight.semiBold,
                backgroundColor: request.status == StatusType.completed.key
                    ? AppColor.completedButton
                    : request.status == StatusType.pending.key
                        ? AppColor.pendingButton
                        : AppColor.onTheWayButton,
                onPressed: () {},
              ),
              const Spacer(),
              const Icon(
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
    );
  }
}
