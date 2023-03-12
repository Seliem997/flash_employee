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

class DutyScreen extends StatelessWidget {
  const DutyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextWidget(
          text: "Duty",
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
            padding: symmetricEdgeInsets(horizontal: 25, vertical: 10),
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffD9EDFA),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        backgroundColor: AppColor.primary,
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Su",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "First Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "9:30 PM - 11:00 PM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "Second Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "1:30 AM - 6:00 AM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffD9EDFA),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        backgroundColor: AppColor.primary,
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Mo",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "First Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "9:30 PM - 11:00 PM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "Second Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "1:30 AM - 6:00 AM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffD9EDFA),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        backgroundColor: AppColor.primary,
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Tu",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "First Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "9:30 PM - 11:00 PM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "Second Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "1:30 AM - 6:00 AM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffC7FFCD),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        backgroundColor: Color(0xff5CD268),
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Wed",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: const TextWidget(
                            text: "Weekend Day!",
                            textSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffD9EDFA),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        backgroundColor: AppColor.primary,
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Thu",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "First Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "9:30 PM - 11:00 PM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "Second Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "1:30 AM - 6:00 AM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffD9EDFA),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        backgroundColor: AppColor.primary,
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Fr",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "First Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "9:30 PM - 11:00 PM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "Second Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "1:30 AM - 6:00 AM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(bottom: 10),
                  backgroundColor: Color(0xffD9EDFA),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomContainer(
                        width: 55,
                        height: 73,
                        backgroundColor: AppColor.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "Sa",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "First Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "9:30 PM - 11:00 PM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          CustomContainer(
                            backgroundColor: Color(0xffD9EDFA),
                            child: Row(
                              children: [
                                const TextWidget(
                                  text: "Second Shift :",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                horizontalSpace(10),
                                const TextWidget(
                                  text: "1:30 AM - 6:00 AM",
                                  textSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
