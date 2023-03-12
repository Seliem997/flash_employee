import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextWidget(
          text: "Request :00021",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: symmetricEdgeInsets(horizontal: 25, vertical: 0),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomContainer(
                    width: 120,
                    height: 32,
                    radiusCircular: 3,
                    backgroundColor: AppColor.pendingButton,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: TextWidget(
                      text: "Pending",
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
                  backgroundColor: Color(0xffE0E0E0),
                  padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
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
                          const TextWidget(
                            text: "00021",
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
                          const TextWidget(
                            text: "Monday, 23 January 2023",
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
                          const TextWidget(
                            text: "11 : 12 PM",
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
                  backgroundColor: Color(0xffE0E0E0),
                  padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
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
                          const TextWidget(
                            text: "FWC1",
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
                                image: AssetImage("assets/images/Nature.png"),
                                fit: BoxFit.cover),
                          ),
                          horizontalSpace(65),
                          const CustomContainer(
                            height: 65,
                            width: 65,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage("assets/images/Location.png"),
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
                          const TextWidget(
                            text: "+9662456787456",
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
                            height: 35,
                            width: 35,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/telephone.png"),
                                fit: BoxFit.fitHeight),
                          ),
                          horizontalSpace(30),
                          const CustomContainer(
                            height: 35,
                            width: 35,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage("assets/images/whatsapp.png"),
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
                  backgroundColor: Color(0xffF1F6FE),
                  padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
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
                          const TextWidget(
                            text: "Car",
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
                            text: "Size :",
                            textSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          horizontalSpace(10),
                          const TextWidget(
                            text: "Small Car",
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
                            text: "Manufacturer :",
                            textSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          horizontalSpace(10),
                          const TextWidget(
                            text: "Mazada",
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
                          const TextWidget(
                            text: "CX3",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                backgroundColor: Color(0xff0400CC),
                              )
                            ],
                          ),
                          horizontalSpace(100),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    image:
                                        AssetImage("assets/images/plate.png"),
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
                  backgroundColor: Color(0xffF1F6FE),
                  padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
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
                          const TextWidget(
                            text: "Wash",
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
                          const TextWidget(
                            text: "Inside & Outside Wash",
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      verticalSpace(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          const TextWidget(
                            text: "70 Min",
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
                  backgroundColor: Color(0xffF1F6FE),
                  padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomContainer(
              width: double.infinity,
              height: 120,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32), topLeft: Radius.circular(32)),
              backgroundColor: Color(0xff9DD0F3),
              padding: symmetricEdgeInsets(horizontal: 20),
              borderColor: AppColor.primary,
              alignment: Alignment.center,
              child: Column(
                children: [
                  verticalSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomContainer(
                        height: 27,
                        width: 27,
                        padding: EdgeInsets.zero,
                        radiusCircular: 0,
                        backgroundColor: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage("assets/images/share.png"),
                            fit: BoxFit.fitHeight),
                      ),
                      Row(
                        children: [
                          DefaultButton(
                            text: "Start",
                            height: 40,
                            width: 178,
                            padding: EdgeInsets.zero,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            onPressed: () {},
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
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  const TextWidget(
                    text: "Contact Customer Service",
                    underLine: true,
                    textSize: 14,
                    color: Color(0xff0067AF),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
