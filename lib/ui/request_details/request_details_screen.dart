import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_employee/main.dart';
import 'package:flash_employee/services/common_service.dart';
import 'package:flash_employee/ui/contact_us/contact_us_screen.dart';
import 'package:flash_employee/ui/request_details/screens/edit_services_screen.dart';
import 'package:flash_employee/ui/request_details/screens/edit_vehicle_screen.dart';
import 'package:flash_employee/ui/request_details/widgets/late_minutes_dialog.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/enum/status_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../events/events/invoice_added_event.dart';
import '../../events/events/request_updated_event.dart';
import '../../events/global_event_bus.dart';
import '../../providers/requests_provider.dart';
import '../../utils/colors.dart';
import '../../utils/snack_bars.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    mainEventBus.on<RequestUpdatedEvent>().listen((event) {
      loadData();
    });
    super.initState();
  }

  void loadData() async {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context, listen: false);
    await requestsProvider.getRequestDetails();
  }

  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);
    return Scaffold(
      appBar: requestsProvider.selectedRequest != null
          ? AppBar(
              title: TextWidget(
                text: "Request :${requestsProvider.selectedRequest!.id}",
                textSize: 18,
                fontWeight: FontWeight.bold,
              ),
              elevation: 0,
              leading: const BackButton(),
              centerTitle: true,
            )
          : null,
      body: requestsProvider.loadingRequestDetails
          ? const DataLoader()
          : requestsProvider.selectedRequest == null
              ? const NoDataPlaceHolder(useExpand: false)
              : Stack(
                  children: [
                    Padding(
                      padding: symmetricEdgeInsets(horizontal: 25, vertical: 0),
                      child: RefreshIndicator(
                        edgeOffset: 0,
                        displacement: 0,
                        onRefresh: () async {
                          loadData();
                        },
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomContainer(
                                width: 120,
                                height: 32,
                                radiusCircular: 3,
                                backgroundColor:
                                    requestsProvider.selectedRequest!.status ==
                                            StatusType.completed.key
                                        ? AppColor.completedButton
                                        : requestsProvider
                                                    .selectedRequest!.status ==
                                                StatusType.pending.key
                                            ? AppColor.pendingButton
                                            : AppColor.onTheWayButton,
                                backgroundColorDark:
                                    requestsProvider.selectedRequest!.status ==
                                            StatusType.completed.key
                                        ? AppColor.completedButton
                                        : requestsProvider
                                                    .selectedRequest!.status ==
                                                StatusType.pending.key
                                            ? AppColor.pendingButton
                                            : AppColor.onTheWayButton,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: TextWidget(
                                  text:
                                      "${requestsProvider.selectedRequest!.status}",
                                  textSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            verticalSpace(24),
                            const TextWidget(
                              text: "Request info",
                              textSize: 15,
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                            verticalSpace(14),
                            CustomContainer(
                              width: double.infinity,
                              radiusCircular: 4,
                              backgroundColor: MyApp.themeMode(context)
                                  ? AppColor.darkScaffoldColor
                                  : const Color(0xffE0E0E0),
                              padding: symmetricEdgeInsets(
                                  horizontal: 20, vertical: 20),
                              borderColor: Colors.grey,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Request ID :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.id}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Date :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.date}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Time :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.time}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(32),
                            const TextWidget(
                              text: "Customer Contact",
                              textSize: 15,
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                            verticalSpace(14),
                            CustomContainer(
                              width: double.infinity,
                              radiusCircular: 4,
                              backgroundColor: MyApp.themeMode(context)
                                  ? AppColor.darkScaffoldColor
                                  : const Color(0xffE0E0E0),
                              padding: symmetricEdgeInsets(
                                  horizontal: 20, vertical: 20),
                              borderColor: Colors.grey,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TextWidget(
                                        text: "Customer ID :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text: requestsProvider
                                            .selectedRequest!.customer!.id
                                            .toString(),
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomContainer(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      elevation: 0,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child:
                                                                CustomContainer(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              height: 50,
                                                              width: 50,
                                                              child: const Icon(
                                                                  Icons.close,
                                                                  size: 30,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          verticalSpace(20),
                                                          CustomContainer(
                                                              height: 300,
                                                              width: 300,
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(requestsProvider
                                                                      .selectedRequest!
                                                                      .locationRequest!
                                                                      .image!))),
                                                        ],
                                                      ),
                                                    ));
                                          },
                                          height: 78,
                                          width: 117,
                                          padding: EdgeInsets.zero,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  requestsProvider
                                                      .selectedRequest!
                                                      .locationRequest!
                                                      .image!))),
                                      horizontalSpace(65),
                                      CustomContainer(
                                        onTap: () {
                                          CommonService.openMap(
                                              double.tryParse(requestsProvider
                                                          .selectedRequest
                                                          ?.locationRequest
                                                          ?.latitude ??
                                                      "") ??
                                                  0,
                                              double.tryParse(requestsProvider
                                                          .selectedRequest
                                                          ?.locationRequest
                                                          ?.langitude ??
                                                      "") ??
                                                  0);
                                        },
                                        height: 65,
                                        width: 65,
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Location.png"),
                                            fit: BoxFit.cover),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Phone number :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.customer!.phone}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomContainer(
                                        onTap: () {
                                          CommonService.callNumber(
                                              requestsProvider.selectedRequest!
                                                  .customer!.phone!,
                                              context);
                                        },
                                        height: 35,
                                        width: 35,
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/telephone.png"),
                                            fit: BoxFit.fitHeight),
                                      ),
                                      horizontalSpace(30),
                                      CustomContainer(
                                        onTap: () {
                                          CommonService.openWhatsapp(
                                              requestsProvider.selectedRequest!
                                                  .customer!.phone!,
                                              context);
                                        },
                                        height: 35,
                                        width: 35,
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/whatsapp.png"),
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(32),
                            const TextWidget(
                              text: "Vehicle info",
                              textSize: 15,
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                            verticalSpace(14),
                            CustomContainer(
                              width: double.infinity,
                              radiusCircular: 4,
                              backgroundColor: MyApp.themeMode(context)
                                  ? AppColor.darkScaffoldColor
                                  : const Color(0xffF1F6FE),
                              padding: symmetricEdgeInsets(
                                  horizontal: 20, vertical: 20),
                              borderColor: AppColor.primary,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Type :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.vehicleRequest!.vehicleTypeName}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      const Spacer(),
                                      if (requestsProvider.editingMode)
                                        CustomContainer(
                                          onTap: () {
                                            navigateTo(
                                                context, EditVehicleScreen());
                                          },
                                          height: 20,
                                          width: 20,
                                          radiusCircular: 0,
                                          borderColorDark: Colors.transparent,
                                          child: Image.asset(
                                              "assets/images/edit-2.png",
                                              color: MyApp.themeMode(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                    ],
                                  ),
                                  verticalSpace(16),
                                  if (requestsProvider.selectedRequest!
                                          .vehicleRequest!.vehicleTypeId !=
                                      2)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const TextWidget(
                                              text: "Size :",
                                              textSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            horizontalSpace(10),
                                            TextWidget(
                                              text:
                                                  "${requestsProvider.selectedRequest!.vehicleRequest!.subVehicleTypeName}",
                                              textSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        verticalSpace(16),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Manufacturer :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.vehicleRequest!.manufacturerName}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Model :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.vehicleRequest!.vehicleModelName}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextWidget(
                                            text: "Color :",
                                            textSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          verticalSpace(10),
                                          requestsProvider.selectedRequest!
                                                      .vehicleRequest!.color !=
                                                  null
                                              ? CustomContainer(
                                                  height: 25,
                                                  width: 40,
                                                  radiusCircular: 3,
                                                  backgroundColor: Color(int.parse(
                                                      "0xff${requestsProvider.selectedRequest!.vehicleRequest!.color!.replaceAll("#", "")}")),
                                                )
                                              : const TextWidget(
                                                  text: "Not Selected")
                                        ],
                                      ),
                                      horizontalSpace(100),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextWidget(
                                            text: "Plate :",
                                            textSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          verticalSpace(10),
                                          CustomContainer(
                                            height: 40,
                                            width: 90,
                                            radiusCircular: 3,
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/plate-2.png"),
                                                fit: BoxFit.fill),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 5,
                                                  top: 1,
                                                  child: CustomContainer(
                                                    width: 50,
                                                    height: 18,
                                                    radiusCircular: 0,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.zero,
                                                    child: TextWidget(
                                                      text:
                                                          "${requestsProvider.selectedRequest!.vehicleRequest!.lettersInArabic}",
                                                      textSize: 10,
                                                      colorDark: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 5,
                                                  bottom: 0,
                                                  child: CustomContainer(
                                                    width: 50,
                                                    height: 18,
                                                    radiusCircular: 0,
                                                    padding: EdgeInsets.zero,
                                                    alignment: Alignment.center,
                                                    child: TextWidget(
                                                      text:
                                                          "${requestsProvider.selectedRequest!.vehicleRequest!.letters}",
                                                      textSize: 10,
                                                      colorDark: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: -4,
                                                  bottom: 0,
                                                  child: CustomContainer(
                                                    width: 50,
                                                    height: 18,
                                                    radiusCircular: 0,
                                                    padding: EdgeInsets.zero,
                                                    alignment: Alignment.center,
                                                    child: TextWidget(
                                                      text:
                                                          "${requestsProvider.selectedRequest!.vehicleRequest!.numbers}",
                                                      textSize: 10,
                                                      colorDark: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: -4,
                                                  top: 0,
                                                  child: CustomContainer(
                                                    width: 50,
                                                    height: 18,
                                                    radiusCircular: 0,
                                                    padding: EdgeInsets.zero,
                                                    alignment: Alignment.center,
                                                    child: TextWidget(
                                                      text:
                                                          "${requestsProvider.selectedRequest!.vehicleRequest!.numbers}",
                                                      textSize: 10,
                                                      colorDark: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(32),
                            const TextWidget(
                              text: "Services",
                              textSize: 15,
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                            verticalSpace(14),
                            CustomContainer(
                              width: double.infinity,
                              radiusCircular: 4,
                              backgroundColor: MyApp.themeMode(context)
                                  ? AppColor.darkScaffoldColor
                                  : const Color(0xffF1F6FE),
                              padding: symmetricEdgeInsets(
                                  horizontal: 20, vertical: 20),
                              borderColor: AppColor.primary,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Service Type :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text: requestsProvider.selectedRequest!
                                                .basicServices!.isNotEmpty
                                            ? "Wash"
                                            : "Other Service",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      const Spacer(),
                                      if (requestsProvider.editingMode)
                                        CustomContainer(
                                          onTap: () {
                                            navigateTo(
                                                context, EditServicesScreen());
                                          },
                                          height: 20,
                                          width: 20,
                                          radiusCircular: 0,
                                          borderColorDark: Colors.transparent,
                                          child: Image.asset(
                                              "assets/images/edit-2.png",
                                              color: MyApp.themeMode(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Basic :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.services![0].title}",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Visibility(
                                    visible: requestsProvider.selectedRequest!
                                        .extraServices!.isNotEmpty,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TextWidget(
                                          text: "Extra :",
                                          textSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        verticalSpace(10),
                                        ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: requestsProvider
                                              .selectedRequest!
                                              .extraServices!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return TextWidget(
                                              text:
                                                  "${requestsProvider.selectedRequest!.extraServices![index].title}",
                                              textSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              verticalSpace(5),
                                        ),
                                        verticalSpace(16),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Service Duration :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text:
                                            "${requestsProvider.selectedRequest!.totalDuration} Min",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(32),
                            const TextWidget(
                              text: "Payment",
                              textSize: 15,
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                            verticalSpace(14),
                            CustomContainer(
                              width: double.infinity,
                              radiusCircular: 4,
                              backgroundColor: MyApp.themeMode(context)
                                  ? AppColor.darkScaffoldColor
                                  : const Color(0xffF1F6FE),
                              padding: symmetricEdgeInsets(
                                  horizontal: 20, vertical: 20),
                              borderColor: AppColor.primary,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Method :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      const TextWidget(
                                        text: "Cash",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Amount :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      const TextWidget(
                                        text: "200 SR",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Tax :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      const TextWidget(
                                        text: "30 SR",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Discount :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      TextWidget(
                                        text: "0 SR",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red[800]!,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(16),
                                  Row(
                                    children: [
                                      const TextWidget(
                                        text: "Total Amount :",
                                        textSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      horizontalSpace(10),
                                      const TextWidget(
                                        text: "214.50 SR",
                                        textSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(135)
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomContainer(
                        width: double.infinity,
                        height: 120,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(32),
                            topLeft: Radius.circular(32)),
                        backgroundColorDark: Color(0xff444444),
                        backgroundColor: const Color(0xffC7E4F8),
                        padding: symmetricEdgeInsets(horizontal: 20),
                        borderColor: MyApp.themeMode(context)
                            ? AppColor.grey
                            : AppColor.primary,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            verticalSpace(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                !requestsProvider.editingMode
                                    ? CustomContainer(
                                        onTap: () {
                                          requestsProvider.savePdf(context);
                                        },
                                        height: 27,
                                        width: 27,
                                        padding: EdgeInsets.zero,
                                        radiusCircular: 0,
                                        backgroundColor: Colors.transparent,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/share.png"),
                                            fit: BoxFit.fitHeight),
                                      )
                                    : Container(),
                                if (requestsProvider.selectedRequest!.status !=
                                        StatusType.completed.key &&
                                    requestsProvider.selectedRequest!.status !=
                                        StatusType.canceled.key)
                                  mainRequestButtons(requestsProvider, context),
                              ],
                            ),
                            verticalSpace(15),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, const ContactUsScreen());
                              },
                              child: const TextWidget(
                                text: "Contact Customer Service",
                                underLine: true,
                                textSize: 14,
                                color: Color(0xff0067AF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Row mainRequestButtons(
      RequestsProvider requestsProvider, BuildContext context) {
    return requestsProvider.editingMode
        ? Row(
            children: [
              Row(
                children: [
                  DefaultButton(
                    text: "Cancel",
                    backgroundColor: AppColor.pendingButton,
                    height: 33,
                    width: 127,
                    padding: EdgeInsets.zero,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    onPressed: () {
                      requestsProvider.editingMode = false;
                    },
                  ),
                  horizontalSpace(25),
                  DefaultButton(
                    text: "Save",
                    backgroundColor: AppColor.completedButton,
                    height: 33,
                    width: 127,
                    padding: EdgeInsets.zero,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    onPressed: () {
                      requestsProvider.editingMode = false;
                    },
                  ),
                  horizontalSpace(25),
                ],
              ),
            ],
          )
        : Row(
            children: [
              if (requestsProvider.selectedRequest!.status! ==
                  StatusType.arrived.key)
                Row(
                  children: [
                    DefaultButton(
                      text: "Edit",
                      backgroundColor: AppColor.pendingButton,
                      height: 33,
                      width: 127,
                      padding: EdgeInsets.zero,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        requestsProvider.editingMode = true;
                      },
                    ),
                    horizontalSpace(25),
                  ],
                ),
              DefaultButton(
                text: buttonTitle(requestsProvider.selectedRequest!.status!),
                backgroundColor: requestsProvider.selectedRequest!.status! ==
                        StatusType.arrived.key
                    ? AppColor.completedButton
                    : null,
                height: requestsProvider.selectedRequest!.status! ==
                        StatusType.arrived.key
                    ? 33
                    : 40,
                width: requestsProvider.selectedRequest!.status! ==
                        StatusType.arrived.key
                    ? 127
                    : 178,
                padding: EdgeInsets.zero,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                onPressed: () async {
                  await requestsProvider.updateRequestStatus(context);
                },
              ),
              horizontalSpace(25),
              if (requestsProvider.selectedRequest!.status ==
                      StatusType.onTheWay2.key ||
                  requestsProvider.selectedRequest!.status ==
                      StatusType.pending.key)
                DefaultButton(
                  text: "Late",
                  height: 33,
                  width: 55,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color(0xffC73E49),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LateMinutesDialog();
                      },
                    );
                  },
                )
            ],
          );
  }

  String buttonTitle(String status) {
    String title = "";
    if (status == StatusType.pending.key) {
      title = "Start";
    } else if (status == StatusType.onTheWay2.key) {
      title = "Arrived";
    } else if (status == StatusType.arrived.key) {
      title = "Complete";
    } else {
      title = "No Action";
    }

    return title;
  }
}
