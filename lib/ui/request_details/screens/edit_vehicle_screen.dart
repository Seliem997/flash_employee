import 'package:flash_employee/providers/requests_provider.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../events/events/request_updated_event.dart';
import '../../../events/global_event_bus.dart';
import '../../../main.dart';
import '../../../models/manufacturersModel.dart';
import '../../../models/vehiclesModelsModel.dart';
import '../../../services/vehicle_service.dart';
import '../../../utils/app_loader.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class EditVehicleScreen extends StatefulWidget {
  const EditVehicleScreen({Key? key}) : super(key: key);

  @override
  State<EditVehicleScreen> createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  late TextEditingController nameController;
  late TextEditingController yearController;
  late TextEditingController numbersController;
  late TextEditingController lettersController;
  String? vehicleColor = "#31A800";
  // int manufacture=2, model=2;

  @override
  void initState() {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context, listen: false);
    nameController = TextEditingController(
        text: requestsProvider.selectedRequest!.vehicleRequest!.name ?? "");
    yearController = TextEditingController(
        text: requestsProvider.selectedRequest!.vehicleRequest!.year ?? "");
    numbersController = TextEditingController(
        text: requestsProvider.selectedRequest!.vehicleRequest!.numbers ?? "");
    lettersController = TextEditingController(
        text: requestsProvider.selectedRequest!.vehicleRequest!.letters ?? "");
    vehicleColor = requestsProvider.selectedRequest!.vehicleRequest!.color;
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context, listen: false);
    requestsProvider.resetDropDownValues();
    requestsProvider.initVehicleEditing();
  }

  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Edit Vehicle",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                      text: 'Manufacturer',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: '(Required)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              requestsProvider.loadingManufacturer
                  ? const DataLoader()
                  : CustomContainer(
                      width: double.infinity,
                      height: 44,
                      radiusCircular: 3,
                      borderColor: Color(0xffE0E0E0),
                      backgroundColor: Color(0xffE0E0E0),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: requestsProvider.selectedManufacture,
                          iconEnabledColor: Colors.black,
                          hint: TextWidget(
                            text: 'Choose Manufacturer',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: const Color(0xFF909090),
                          ),
                          icon: SvgPicture.asset(
                            'assets/svg/arrow_down.svg',
                          ),
                          items: List.generate(
                              requestsProvider.manufacturerDataList.length,
                              (index) => DropdownMenuItem<ManufacturerData>(
                                  value: requestsProvider
                                      .manufacturerDataList[index],
                                  child: Text(
                                      requestsProvider
                                          .manufacturerDataList[index].name!,
                                      style: TextStyle(
                                          color: MyApp.themeMode(context)
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16)))),
                          onChanged: (value) async {
                            requestsProvider.setSelectedManufacture(value!);
                            await requestsProvider
                                .getVehiclesModels(
                                    context: context, manufactureId: value.id!)
                                .then((result) {});
                          },
                          menuMaxHeight: 25.h,
                        ),
                      ),
                    ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: 'Model',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: '(Required)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              requestsProvider.loadingModels
                  ? const DataLoader()
                  : CustomContainer(
                      width: double.infinity,
                      height: 44,
                      radiusCircular: 3,
                      padding: symmetricEdgeInsets(horizontal: 16),
                      borderColor: Color(0xffE0E0E0),
                      backgroundColor: Color(0xffE0E0E0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: requestsProvider.selectedVehicleModel,
                          iconEnabledColor: Colors.black,
                          hint: TextWidget(
                            text: 'Choose Model',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: const Color(0xFF909090),
                          ),
                          icon: SvgPicture.asset(
                            'assets/svg/arrow_down.svg',
                          ),
                          items: List.generate(
                              requestsProvider.vehiclesModelsDataList.length,
                              (index) => DropdownMenuItem<VehiclesModelsData>(
                                  value: requestsProvider
                                      .vehiclesModelsDataList[index],
                                  child: Text(
                                      requestsProvider
                                          .vehiclesModelsDataList[index].name!,
                                      style: TextStyle(
                                          color: MyApp.themeMode(context)
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16)))),
                          onChanged: (value) async {
                            requestsProvider.setSelectedVehicle(value!);
                            // model = value.id!;
                          },
                          menuMaxHeight: 25.h,
                        ),
                      ),
                    ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: 'Nickname',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: '(Optional)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              CustomSizedBox(
                height: 44,
                width: double.infinity,
                child: DefaultFormField(
                  controller: nameController,
                  hintText: 'Type name......',
                  fillColor: AppColor.borderGray,
                ),
              ),
              verticalSpace(24),
              Row(
                children: [
                  TextWidget(
                      text: 'Year',
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(6),
                  TextWidget(
                    text: '(Optional)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(12),
              CustomSizedBox(
                height: 44,
                width: double.infinity,
                child: DefaultFormField(
                  controller: yearController,
                  hintText: 'Enter Year',
                ),
              ),
              verticalSpace(24),
              TextWidget(
                text: 'Color',
                textSize: MyFontSize.size15,
                fontWeight: MyFontWeight.medium,
              ),
              verticalSpace(12),
              Row(
                children: [
                  requestsProvider.selectedRequest!.vehicleRequest!.color !=
                              null ||
                          vehicleColor != null
                      ? CustomContainer(
                          height: 35,
                          width: 80,
                          radiusCircular: 3,
                          borderColorDark: Colors.white,
                          backgroundColorDark: Color(int.parse(
                              "${vehicleColor ?? ("0xff" + requestsProvider.selectedRequest!.vehicleRequest!.color!.replaceAll("#", ""))}")),
                          backgroundColor: Color(int.parse(
                              "${vehicleColor ?? ("0xff" + requestsProvider.selectedRequest!.vehicleRequest!.color!.replaceAll("#", ""))}")),
                        )
                      : const TextWidget(text: "Not Selected"),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        TextEditingController colorController =
                            TextEditingController();
                        Color pickerColor = AppColor.primary;
                        showDialog(
                          context: context,
                          builder: (context) =>
                              StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Text("Pick Color"),
                              content: SingleChildScrollView(
                                  child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: (value) {
                                  vehicleColor = "${value.value}";
                                },
                              )),
                              actionsPadding: symmetricEdgeInsets(
                                  horizontal: 30, vertical: 50),
                              actions: <Widget>[
                                DefaultFormField(
                                  controller: colorController,
                                  hintText: "Color hex ex.. #EBF4FB",
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.length == 7) {
                                        if (value.contains("#")) {
                                          int parsedColor = 0;
                                          if (int.tryParse(
                                                  "0xff${value.replaceAll("#", "")}") !=
                                              null) {
                                            parsedColor = int.parse(
                                                "0xff${value.replaceAll("#", "")}");
                                            vehicleColor = "$parsedColor";
                                            pickerColor = Color(parsedColor);
                                            print(pickerColor);
                                          }
                                        }
                                      }
                                    });
                                  },
                                ),
                                verticalSpace(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    DefaultButton(
                                        text: "Cancel",
                                        backgroundColor: Colors.transparent,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                    horizontalSpace(10),
                                    DefaultButton(
                                        text: "Add Color",
                                        onPressed: () {
                                          // vehiclesProvider.addColor(
                                          //     vehiclesProvider.newColor);
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              verticalSpace(20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Numbers',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.medium,
                      ),
                      verticalSpace(12),
                      CustomSizedBox(
                        height: 44,
                        width: 160,
                        child: DefaultFormField(
                          controller: numbersController,
                          hintText: 'Type Numbers',
                          isNumber: true,
                        ),
                      ),
                    ],
                  ),
                  horizontalSpace(25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Letters',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.medium,
                      ),
                      verticalSpace(12),
                      CustomSizedBox(
                        height: 44,
                        width: 160,
                        child: DefaultFormField(
                          controller: lettersController,
                          hintText: 'Type Letters',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(32),
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/plate-2.png'),
              ),
              verticalSpace(12),
              Align(
                alignment: Alignment.center,
                child: TextWidget(
                  text: 'Vehicle registration plate',
                  textSize: MyFontSize.size14,
                  fontWeight: MyFontWeight.medium,
                  color: AppColor.grey,
                ),
              ),
              verticalSpace(36),
              DefaultButton(
                width: 345,
                height: 48,
                text: 'Save',
                fontSize: 21,
                fontWeight: MyFontWeight.bold,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (requestsProvider.selectedVehicleModel == null) {
                    CustomSnackBars.failureSnackBar(
                        context, "Vehicle Model Required");
                  } else {
                    final VehicleService vehicleService = VehicleService();
                    AppLoader.showLoader(context);
                    await vehicleService.updateVehicle(
                      vehicleId:
                          requestsProvider.selectedRequest!.vehicleRequest!.id!,
                      vehicleTypeId: requestsProvider
                          .selectedRequest!.vehicleRequest!.vehicleTypeId!,
                      manufacturerId: requestsProvider.selectedManufacture!.id!,
                      vehicleModelId:
                          requestsProvider.selectedVehicleModel!.id!,
                      numbers: numbersController.text,
                      letters: lettersController.text,
                      color: vehicleColor,
                      name: nameController.text,
                      year: yearController.text,
                      subVehicleTypeId: 1,
                    );
                    mainEventBus.fire(RequestUpdatedEvent());
                    AppLoader.stopLoader();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
