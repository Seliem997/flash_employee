import 'package:flash_employee/events/events/request_updated_event.dart';
import 'package:flash_employee/events/global_event_bus.dart';
import 'package:flash_employee/models/servicesModel.dart';
import 'package:flash_employee/providers/requests_provider.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../utils/enum/serviceType.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/data_loader.dart';
import '../../widgets/spaces.dart';
import 'package:flash_employee/ui/widgets/custom_button.dart';

import 'package:flutter/services.dart';
import '../../../utils/colors.dart';
import '../widgets/extra_service_widget.dart';

class EditServicesScreen extends StatefulWidget {
  const EditServicesScreen({Key? key}) : super(key: key);

  @override
  State<EditServicesScreen> createState() => _EditServicesScreenState();
}

class _EditServicesScreenState extends State<EditServicesScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context, listen: false);
    requestsProvider.initServiceEditing();
  }

  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Edit Services",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: CustomContainer(
        padding: symmetricEdgeInsets(horizontal: 25, vertical: 30),
        borderColorDark: Colors.transparent,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: "Service Type",
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.secondary,
                ),
                verticalSpace(12),
                CustomContainer(
                  width: double.infinity,
                  radiusCircular: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  borderColor: Color(0xffE0E0E0),
                  backgroundColor: Color(0xffE0E0E0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: requestsProvider.selectedServiceType,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: MyApp.themeMode(context)
                              ? Colors.white
                              : Colors.black,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        hint: TextWidget(
                          text: "Select Service type",
                          color: MyApp.themeMode(context)
                              ? Colors.white
                              : Colors.black,
                          textSize: 16,
                        ),
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(),
                        items: List.generate(
                            serviceTypes.length,
                            (index) => DropdownMenuItem<ServiceType>(
                                value: serviceTypes[index],
                                child: Text(serviceTypes[index].key,
                                    style: TextStyle(
                                        color: MyApp.themeMode(context)
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16)))),
                        onChanged: null),
                  ),
                )
              ],
            ),
            verticalSpace(25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: "Basic Service",
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.secondary,
                ),
                verticalSpace(12),
                requestsProvider.loadingBasicServices
                    ? DataLoader()
                    : CustomContainer(
                        width: double.infinity,
                        radiusCircular: 5,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        borderColor: const Color(0xffE0E0E0),
                        backgroundColor: const Color(0xffE0E0E0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: requestsProvider.selectedBasicService,
                            iconSize: 24,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: MyApp.themeMode(context)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            elevation: 16,
                            hint: Center(
                              child: TextWidget(
                                text: "Select Basic Service",
                                color: MyApp.themeMode(context)
                                    ? Colors.white
                                    : Colors.black,
                                textSize: 16,
                              ),
                            ),
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(),
                            items: List.generate(
                                requestsProvider.basicServicesList.length,
                                (index) => DropdownMenuItem<ServiceData>(
                                    value: requestsProvider
                                        .basicServicesList[index],
                                    child: Text(
                                        "${requestsProvider.basicServicesList[index].title}",
                                        style: TextStyle(
                                            color: MyApp.themeMode(context)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16)))),
                            onChanged: (newValue) {
                              requestsProvider.selectedBasicService = newValue;
                            },
                          ),
                        ),
                      )
              ],
            ),
            verticalSpace(25),
            if (requestsProvider.selectedServiceType == ServiceType.wash)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Extra Services',
                    textSize: MyFontSize.size16,
                    fontWeight: MyFontWeight.semiBold,
                    color: const Color(0xFF4B4B4B),
                  ),
                  verticalSpace(14),
                  CustomContainer(
                    width: double.infinity,
                    borderColorDark: Colors.transparent,
                    radiusCircular: 4,
                    backgroundColor: const Color(0xFFF9F9F9),
                    child: requestsProvider.extraServicesList.isEmpty
                        ? const DataLoader()
                        : Padding(
                            padding: onlyEdgeInsets(
                              start: 11,
                              end: 21,
                              bottom: 22,
                              top: 22,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  ExtraServicesWidget(
                                extraService:
                                    requestsProvider.extraServicesList[index],
                                infoOnPressed: () {},
                              ),
                              separatorBuilder: (context, index) =>
                                  verticalSpace(14),
                              itemCount:
                                  requestsProvider.extraServicesList.length,
                            ),
                          ),
                  ),
                ],
              ),
            DefaultButton(
              text: "Submit",
              height: 48,
              fontSize: 16,
              width: double.infinity,
              onPressed: () async {
                await requestsProvider.updateRequestServices(context);
                mainEventBus.fire(RequestUpdatedEvent());
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
