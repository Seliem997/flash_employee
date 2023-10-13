import 'package:flash_employee/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/font_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

import 'package:flash_employee/events/events/invoice_added_event.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../events/global_event_bus.dart';
import '../../../providers/invoices_provider.dart';

class NoImageDialog extends StatelessWidget {
  const NoImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InvoicesProvider invoicesProvider =
        Provider.of<InvoicesProvider>(context);
    return Dialog(
      child: CustomContainer(
        // width: 321,
        height: 300,
        radiusCircular: 12,
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 38),
        child: Column(
          children: [
            TextWidget(
              text: 'Warning',
              fontWeight: MyFontWeight.bold2,
              textSize: MyFontSize.size19,
              color: const Color(0xFFF24955),
            ),
            verticalSpace(24),
            TextWidget(
              text: 'No Photo Added!',
              fontWeight: MyFontWeight.semiBold,
              textSize: MyFontSize.size20,
              color: Colors.black,
            ),
            verticalSpace(24),
            TextWidget(
              text:
                  'You will be responsible for this amount if it is not approved from management',
              fontWeight: MyFontWeight.regular,
              textAlign: TextAlign.center,
              textSize: MyFontSize.size16,
              color: Colors.black,
            ),
            verticalSpace(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(
                  text: 'Cancel and back',
                  fontWeight: MyFontWeight.bold,
                  fontSize: MyFontSize.size14,
                  height: 33,
                  width: 155,
                  backgroundColor: const Color(0xFFB85F66),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                DefaultButton(
                  text: 'Submit',
                  fontWeight: MyFontWeight.bold,
                  fontSize: MyFontSize.size14,
                  height: 33,
                  width: 96,
                  backgroundColor: const Color(0xFF6BB85F),
                  onPressed: () async {
                    AppLoader.showLoader(context);
                    await invoicesProvider.addInvoice().then((value) {
                      AppLoader.stopLoader();
                      if (value == Status.success) {
                        CustomSnackBars.successSnackBar(
                            context, "Invoice Added!");
                        mainEventBus.fire(InvoiceAddedEvent());
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                      } else {
                        CustomSnackBars.somethingWentWrongSnackBar(context);
                      }
                    });
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
