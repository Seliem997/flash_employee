import 'package:flash_employee/models/transactionsModel.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/enum/date_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/enum/transaction_type.dart';
import '../../../../utils/font_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/spaces.dart';

class TransactionItem extends StatelessWidget {
  final TransactionData transaction;
  const TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        // navigateTo(context, RequestDetailsScreen());
      },
      width: 345,
      radiusCircular: 6,
      backgroundColor:
          transaction.type == FromToTransactionType.fromEmployeeToEmployee.key
              ? Color(0xffCBFFAB)
              : Color(0xffFFC0C3),
      padding: symmetricEdgeInsets(vertical: 13, horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                TextWidget(
                    text: "Name",
                    textSize: 14,
                    fontWeight: MyFontWeight.semiBold),
                const Spacer(),
                TextWidget(
                    text: "Reason",
                    textSize: 14,
                    fontWeight: MyFontWeight.semiBold),
                const Spacer(),
                TextWidget(
                    text: "Quantity",
                    textSize: 14,
                    fontWeight: MyFontWeight.semiBold),
              ],
            ),
          ),
          verticalSpace(15),
          ListView.separated(
            itemCount: transaction.transactionMaterials!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => verticalSpace(12),
            itemBuilder: (context, index) {
              return CustomContainer(
                onTap: () {
                  // navigateTo(context, RequestDetailsScreen());
                },
                width: 345,
                height: 38,
                radiusCircular: 6,
                backgroundColor: Colors.white,
                padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      width: 110,
                      borderColorDark: Colors.transparent,
                      child: TextWidget(
                        text: transaction
                                .transactionMaterials![index].materialName ??
                            "",
                        textSize: 12,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                    ),
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      width: 120,
                      borderColorDark: Colors.transparent,
                      child: TextWidget(
                        text: transaction.transactionMaterials![index]
                                .transactionReasonName ??
                            "",
                        color: Colors.black,
                        textSize: 12,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                    ),
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      width: 30,
                      borderColorDark: Colors.transparent,
                      child: TextWidget(
                        text: transaction.transactionMaterials![index].quantity
                            .toString(),
                        textSize: 12,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          verticalSpace(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomContainer(
                width: 110,
                radiusCircular: 5,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 35,
                backgroundColor: Color(0xff565656),
                alignment: Alignment.center,
                child: TextWidget(
                  text: transaction.type ==
                          FromToTransactionType.fromWarehouseToEmployee.key
                      ? transaction.warehouse!.name ?? ""
                      : "Me",
                  color: Colors.white,
                  textSize: 12,
                ),
              ),
              CustomContainer(
                  height: 35,
                  width: 45,
                  borderColorDark: Colors.transparent,
                  child: Image.asset("assets/images/arrow-right 1.png")),
              CustomContainer(
                width: 110,
                radiusCircular: 5,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 35,
                backgroundColor: Color(0xff565656),
                alignment: Alignment.center,
                child: TextWidget(
                  text: transaction.type ==
                          FromToTransactionType.fromWarehouseToEmployee.key
                      ? "Me"
                      : transaction.employeeTo!.username ?? "",
                  color: Colors.white,
                  textSize: 12,
                ),
              ),
            ],
          ),
          Divider(thickness: 1.5),
          verticalSpace(15),
          Column(
            children: [
              Row(
                children: [
                  TextWidget(
                    text: 'Transaction ID : ',
                    textSize: 13,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  TextWidget(
                    text: transaction.id.toString(),
                    textSize: 13,
                    fontWeight: MyFontWeight.medium,
                    color: AppColor.grey,
                  ),
                ],
              ),
              verticalSpace(12),
              Row(
                children: [
                  TextWidget(
                    text: 'Transaction Type : ',
                    textSize: 13,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  TextWidget(
                    text: transaction.type ==
                            FromToTransactionType.fromEmployeeToEmployee.key
                        ? "Sell"
                        : "Buy",
                    textSize: 13,
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
                    text: DateFormat(DFormat.hm.key)
                        .format(DateTime.parse(transaction.createdAt!)),
                    textSize: 13,
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
                    text: DateFormat(DFormat.dmy.key)
                        .format(DateTime.parse(transaction.createdAt!)),
                    textSize: 13,
                    fontWeight: MyFontWeight.medium,
                    color: AppColor.grey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
