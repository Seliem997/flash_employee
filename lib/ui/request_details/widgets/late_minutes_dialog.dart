import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../providers/requests_provider.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';

class LateMinutesDialog extends StatefulWidget {
  LateMinutesDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LateMinutesDialog> createState() => _LateMinutesDialogState();
}

class _LateMinutesDialogState extends State<LateMinutesDialog> {
  TextEditingController minController = TextEditingController();
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: CustomContainer(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        padding: symmetricEdgeInsets(horizontal: 25, vertical: 30),
        width: 321,
        height: 211,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: "Late time in minute?"),
            verticalSpace(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                  onTap: () {
                    if (counter > 0) {
                      counter--;
                      minController =
                          TextEditingController(text: counter.toString());
                      setState(() {});
                    }
                  },
                  margin: EdgeInsets.only(right: 10),
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/images/minus.png'),
                      fit: BoxFit.fitHeight),
                ),
                SizedBox(
                    width: 80,
                    child: DefaultFormField(
                      hintText: "0",
                      controller: minController,
                      height: 30,
                      isNumber: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(3)],
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        counter = int.parse(value);
                      },
                    )),
                CustomContainer(
                  onTap: () {
                    counter++;
                    minController =
                        TextEditingController(text: counter.toString());
                    setState(() {});
                  },
                  margin: EdgeInsets.only(left: 10),
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/images/plus.png'),
                      fit: BoxFit.fitHeight),
                ),
                horizontalSpace(15),
                TextWidget(text: "Min", textSize: 12)
              ],
            ),
            verticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultButton(
                  text: "Cancel",
                  width: 105,
                  height: 33,
                  backgroundColor: AppColor.pendingButton,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                DefaultButton(
                  text: "Submit",
                  width: 125,
                  height: 33,
                  backgroundColor: AppColor.completedButton,
                  onPressed: () {
                    if(counter>0)
                      {
                        requestsProvider.lateRequest(context, counter);

                      }else{
                      CustomSnackBars.failureSnackBar(context, "Late minutes cannot be 0!");
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
