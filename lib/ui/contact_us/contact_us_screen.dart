import 'package:flash_employee/ui/duty/duty_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextWidget(
          text: "Contact Us",
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
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                          text: "Customer service",
                          textSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(17),
                  TextWidget(
                    text: "Supervisors",
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Ferdin",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Ankit",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(17),
                  TextWidget(
                    text: "Clerks",
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Zainab",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Ghadeer",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(17),
                  TextWidget(
                    text: "Manager",
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Ali",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Mohammed",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(17),
                  TextWidget(
                    text: "Owner",
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Qassim",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  CustomContainer(
                    width: 55,
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    radiusCircular: 6,
                    backgroundColor: Color(0xffE0E0E0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: const TextWidget(
                            text: "Ahmed",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DefaultButton(
                          text: "Duty",
                          padding: EdgeInsets.zero,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 25,
                          width: 58,
                          onPressed: () {
                            navigateTo(context, DutyScreen());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                            horizontalSpace(10),
                            const CustomContainer(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/whatsapp.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
