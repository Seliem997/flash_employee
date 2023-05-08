import 'package:flash_employee/main.dart';
import 'package:flash_employee/services/common_service.dart';
import 'package:flash_employee/ui/contact_us/contact_us_screen.dart';
import 'package:flash_employee/ui/request_details/widgets/late_minutes_dialog.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/enum/status_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
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
              leading: BackButton(),
              centerTitle: true,
            )
          : null,
      body: requestsProvider.loadingRequestDetails
          ? DataLoader()
          : requestsProvider.selectedRequest == null
              ? NoDataPlaceHolder(useExpand: false)
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
                            TextWidget(
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
                                  : Color(0xffE0E0E0),
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
                            TextWidget(
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
                                  : Color(0xffE0E0E0),
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
                                      const CustomContainer(
                                        height: 78,
                                        width: 117,
                                        padding: EdgeInsets.zero,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Nature.png"),
                                            fit: BoxFit.cover),
                                      ),
                                      horizontalSpace(65),
                                      CustomContainer(
                                        onTap: () {
                                          // CommonService.openMap(latitude, longitude );
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
                            TextWidget(
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
                                  : Color(0xffF1F6FE),
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
                                          CustomContainer(
                                            height: 25,
                                            width: 40,
                                            radiusCircular: 3,
                                            backgroundColor: Colors.black,
                                            // backgroundColor: Color(int.parse(
                                            //     "0xff${requestsProvider.selectedRequest!.customer!.vehicle![0].color!.replaceAll("#", "")}")),
                                          )
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
                                            height: 30,
                                            width: 60,
                                            radiusCircular: 3,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/plate.png"),
                                                fit: BoxFit.cover),
                                            backgroundColor: Color(0xff0400CC),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(32),
                            TextWidget(
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
                                  : Color(0xffF1F6FE),
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
                                                    .services![0].type ==
                                                "basic"
                                            ? "Wash"
                                            : "Other Service",
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
                                  Column(
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
                                      const TextWidget(
                                        text: "Nano Shampoo",
                                        textSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      verticalSpace(3),
                                      const TextWidget(
                                        text: "Full Chair Washing",
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
                            TextWidget(
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
                                  : Color(0xffF1F6FE),
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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            topLeft: Radius.circular(32)),
                        backgroundColor: MyApp.themeMode(context)
                            ? AppColor.darkScaffoldColor
                            : Color(0xff9DD0F3),
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
                                CustomContainer(
                                  onTap: () {
                                    requestsProvider.savePdf();
                                  },
                                  height: 27,
                                  width: 27,
                                  padding: EdgeInsets.zero,
                                  radiusCircular: 0,
                                  backgroundColor: Colors.transparent,
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/share.png"),
                                      fit: BoxFit.fitHeight),
                                ),
                                if (requestsProvider.selectedRequest!.status !=
                                        StatusType.completed.key &&
                                    requestsProvider.selectedRequest!.status !=
                                        StatusType.canceled.key)
                                  Row(
                                    children: [
                                      DefaultButton(
                                        text: buttonTitle(requestsProvider
                                            .selectedRequest!.status!),
                                        height: 40,
                                        width: 178,
                                        padding: EdgeInsets.zero,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        onPressed: () async {
                                          await requestsProvider
                                              .updateRequestStatus(context);
                                        },
                                      ),
                                      horizontalSpace(25),
                                      DefaultButton(
                                        text: "Late",
                                        height: 33,
                                        width: 55,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Color(0xffC73E49),
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
                                  ),
                              ],
                            ),
                            verticalSpace(15),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, ContactUsScreen());
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

  String buttonTitle(String status) {
    String title = "";
    if (status == StatusType.pending.key) {
      title = "Start";
    } else if (status == StatusType.onTheWay2.key) {
      title = "Arrived";
    } else if (status == StatusType.arrived.key) {
      title = "Completed";
    } else {
      title = "No Action";
    }

    return title;
  }
}
