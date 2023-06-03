import 'package:change_case/change_case.dart';
import 'package:flash_employee/main.dart';
import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/transactions_provider.dart';
import '../../../../utils/font_styles.dart';
import '../../../widgets/spaces.dart';
import '../../../widgets/text_widget.dart';

class ConfirmTransactionDialog extends StatefulWidget {
  const ConfirmTransactionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmTransactionDialog> createState() =>
      _ConfirmTransactionDialogState();
}

class _ConfirmTransactionDialogState extends State<ConfirmTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    final TransactionsProvider transactionsProvider =
        Provider.of<TransactionsProvider>(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor:
          MyApp.themeMode(context) ? Color(0xff444444) : Colors.transparent,
      child: CustomContainer(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        padding: symmetricEdgeInsets(horizontal: 25, vertical: 30),
        width: 357,
        height: 478,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: "Confirm the transaction please",
              textSize: 18,
              fontWeight: FontWeight.bold,
            ),
            verticalSpace(40),
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
            CustomContainer(
              height: 130,
              borderColorDark: Colors.transparent,
              child: ListView.separated(
                itemCount: transactionsProvider.selectedItems!.length,
                shrinkWrap: true,
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
                    backgroundColor: Color(0xffCDCDCD),
                    padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomContainer(
                          borderColorDark: Colors.transparent,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          width: 110,
                          child: TextWidget(
                            text: transactionsProvider
                                .selectedItems![index].name!,
                            textSize: 12,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                        ),
                        CustomContainer(
                          borderColorDark: Colors.transparent,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          width: 120,
                          child: TextWidget(
                            text: transactionsProvider
                                .selectedItems![index].reason!.name!
                                .toCapitalCase(),
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
                            text:
                                '${transactionsProvider.selectedItems![index].neededQuantity}',
                            textSize: 12,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(thickness: 1.5),
            verticalSpace(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text: "From",
                        textSize: 14,
                        fontWeight: MyFontWeight.semiBold),
                    verticalSpace(10),
                    CustomContainer(
                      width: 110,
                      radiusCircular: 5,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 35,
                      backgroundColor: Color(0xff9F9F9F),
                      alignment: Alignment.center,
                      child: TextWidget(
                        text: transactionsProvider.selectedWarehouse!.name!
                            .toCapitalCase(),
                        color: Colors.white,
                        textSize: 12,
                      ),
                    ),
                  ],
                ),
                CustomContainer(
                    borderColorDark: Colors.transparent,
                    height: 35,
                    width: 45,
                    child: Image.asset("assets/images/arrow-right 1.png")),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text: "To",
                        textSize: 14,
                        fontWeight: MyFontWeight.semiBold),
                    verticalSpace(10),
                    CustomContainer(
                      width: 110,
                      radiusCircular: 5,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 35,
                      backgroundColor: Color(0xff9F9F9F),
                      alignment: Alignment.center,
                      child: TextWidget(
                        text: transactionsProvider.selectedEmployee != null
                            ? transactionsProvider.selectedEmployee!.username!
                                .toCapitalCase()
                            : "Me",
                        color: Colors.white,
                        textSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultButton(
                  text: "Cancel",
                  height: 35,
                  width: 143,
                  backgroundColor: Color(0xffB85F66),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                horizontalSpace(18),
                DefaultButton(
                  text: "Submit",
                  height: 35,
                  width: 143,
                  backgroundColor: Color(0xff6BB85F),
                  onPressed: () {
                    transactionsProvider.addTransaction(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
