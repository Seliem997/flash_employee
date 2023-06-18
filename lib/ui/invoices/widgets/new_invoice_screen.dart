import 'dart:io';

import 'package:flash_employee/events/events/invoice_added_event.dart';
import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../events/global_event_bus.dart';
import '../../../main.dart';
import '../../../providers/invoices_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum/date_formats.dart';
import '../../../utils/enum/languages.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/labelWithInput.dart';
import '../../widgets/required_label.dart';
import '../../widgets/small_icon_rounded.dart';
import '../../widgets/spaces.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final InvoicesProvider invoicesProvider =
        Provider.of<InvoicesProvider>(context, listen: false);
    await invoicesProvider.getInvoicesTypes();
  }

  @override
  Widget build(BuildContext context) {
    final InvoicesProvider invoicesProvider =
        Provider.of<InvoicesProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      key: globalKey,
      appBar: AppBar(
        title: const TextWidget(
          text: "New Invoice",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: invoicesProvider.loadingInvoiceTypes
          ? DataLoader()
          : CustomContainer(
              padding: symmetricEdgeInsets(horizontal: 25, vertical: 20),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      LabelWithInput(
                        isBlue: true,
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse(
                              '${DateTime.now().year + 1}-12-30',
                            ),
                          ).then((value) {
                            invoicesProvider.newInvoiceDate = value;
                          });
                        },
                        title: "Date",
                        value: invoicesProvider.newInvoiceDate != null
                            ? DateFormat(DFormat.dmy.key, LanguageKey.en.key)
                                .format(invoicesProvider.newInvoiceDate!)
                            : "Today",
                        iconPath: "assets/images/calendar.png",
                      ),
                      RequiredLabel(condition: invoicesProvider.dateError),
                      verticalSpace(24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: "Invoice Type",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondary,
                          ),
                          verticalSpace(12),
                          CustomContainer(
                            width: double.infinity,
                            radiusCircular: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            height: 50,
                            borderColor: Color(0xffE0E0E0),
                            backgroundColor: Color(0xffE0E0E0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: invoicesProvider.selectedInvoiceTypeData,
                                iconSize: 24,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: MyApp.themeMode(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                elevation: 16,
                                hint: TextWidget(
                                  text: "Select invoice type",
                                  color: MyApp.themeMode(context)
                                      ? Colors.white
                                      : Colors.black,
                                  textSize: 16,
                                ),
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(),
                                items: List.generate(
                                    invoicesProvider.invoicesTypes!.length,
                                    (index) =>
                                        DropdownMenuItem<InvoiceTypeData>(
                                            value: invoicesProvider
                                                .invoicesTypes![index],
                                            child: Text(
                                                invoicesProvider
                                                    .invoicesTypes![index]
                                                    .name!,
                                                style: TextStyle(
                                                    color:
                                                        MyApp.themeMode(context)
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontSize: 16)))),
                                onChanged: (newValue) {
                                  // error = false;
                                  invoicesProvider.selectedInvoiceTypeData =
                                      newValue;
                                  print(newValue!.toJson());
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      RequiredLabel(condition: invoicesProvider.typeError),
                      verticalSpace(24),
                      LabelWithInput(
                        onTap: () async {
                          await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            invoicesProvider.selectedTime = value;
                          });
                        },
                        title: "Time",
                        value: invoicesProvider.selectedTime != null
                            ? "${invoicesProvider.selectedTime!.hour}:${invoicesProvider.selectedTime!.minute}"
                            : "Now",
                        iconPath: "assets/images/clock.png",
                      ),
                      RequiredLabel(condition: invoicesProvider.timeError),
                      verticalSpace(24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            text: "Invoice amount",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondary,
                          ),
                          verticalSpace(12),
                          SizedBox(
                            height: 6.5.h,
                            child: DefaultFormField(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              textInputAction: TextInputAction.next,
                              hintText: "0.0",
                              isDecimalNumber: true,
                              suffixIcon: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("SR"),
                              ),
                              filled: true,
                              fillColor: Color(0xffE0E0E0),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty &&
                                    double.tryParse(value) != 0) {
                                  invoicesProvider.invoiceAmount =
                                      double.parse(value);
                                  invoicesProvider.amountError = false;
                                  invoicesProvider.notifyListeners();
                                } else {
                                  invoicesProvider.amountError = true;
                                  invoicesProvider.notifyListeners();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      RequiredLabel(condition: invoicesProvider.amountError),
                      verticalSpace(24),
                      Column(
                        children: [
                          TextWidget(
                            text: "Invoice Photo",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondary,
                          ),
                          verticalSpace(11),
                          CustomContainer(
                            height: 105,
                            width: 227,
                            borderColorDark: Colors.transparent,
                            child: invoicesProvider.invoicePhoto != null
                                ? Stack(
                                    children: [
                                      if (invoicesProvider.invoicePhoto != null)
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: FileImage(File(
                                                        invoicesProvider
                                                            .invoicePhoto!
                                                            .path)),
                                                    fit: BoxFit.fitHeight)),
                                            clipBehavior: Clip.hardEdge),
                                      Visibility(
                                        visible:
                                            invoicesProvider.invoicePhoto !=
                                                null,
                                        child: Positioned(
                                            top: 8,
                                            right: 8,
                                            child: GestureDetector(
                                              onTap: () {
                                                invoicesProvider
                                                    .removeAttachment();
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white70),
                                                  padding: EdgeInsets.all(5),
                                                  child: Icon(Icons.close,
                                                      size: 15,
                                                      color: Colors.red)),
                                            )),
                                      ),
                                    ],
                                  )
                                : Image.asset("assets/images/upload.png"),
                            onTap: () {
                              if (invoicesProvider.invoicePhoto != null) {
                                invoicesProvider.removeAttachment();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DefaultButton(
                                            text: "Select a photo from gallery",
                                            height: 50,
                                            width: double.infinity,
                                            onPressed: () async {
                                              invoicesProvider.uploadAttachment(
                                                  ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          verticalSpace(15),
                                          DefaultButton(
                                            text: "Take a photo",
                                            height: 50,
                                            width: double.infinity,
                                            onPressed: () async {
                                              invoicesProvider.uploadAttachment(
                                                  ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DefaultButton(
                      text: "Submit",
                      height: 48,
                      fontSize: 16,
                      width: double.infinity,
                      onPressed: () async {
                        if (invoicesProvider.checkValidation(context)) {
                          AppLoader.showLoader(context);
                          await invoicesProvider.addInvoice().then((value) {
                            AppLoader.stopLoader();
                            if (value == Status.success) {
                              CustomSnackBars.successSnackBar(
                                  context, "Invoice Added!");
                              mainEventBus.fire(InvoiceAddedEvent());
                              Navigator.pop(context, true);
                            } else {
                              CustomSnackBars.somethingWentWrongSnackBar(
                                  context);
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
