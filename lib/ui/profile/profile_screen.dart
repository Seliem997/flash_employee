import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/utils/cache_helper.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flash_employee/utils/enum/shared_preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/font_styles.dart';
import '../home/home_screen.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/image_editable.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode =
      const CountryCode(name: "Saudi Arabia", code: "SA", dialCode: "+966");
  TextEditingController phoneController = TextEditingController(
      text: CacheHelper.returnData(key: CacheKey.phoneNumber));

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomContainer(
            height: 301,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(45),
                bottomLeft: Radius.circular(45)),
            backgroundColor: Color(0xffC7E4F8),
            child: Column(
              children: [
                AppBar(
                  title: const TextWidget(
                    text: "My Profile",
                    textSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 0,
                  leading: BackButton(color: Colors.black),
                  actions: [
                    IconButton(
                        onPressed: () {
                          navigateAndFinish(context, HomeScreen());
                        },
                        icon: Icon(Icons.home, color: AppColor.black))
                  ],
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                ),
                ImageEditable(
                  imageUrl: userDataProvider.userImage!,
                  height: 111,
                  width: 111,
                  showEditIcon: true,
                ),
                verticalSpace(20),
                TextWidget(
                  text: userDataProvider.userName!,
                  textSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                verticalSpace(10),
                const TextWidget(
                    text: "Position in Admin",
                    textSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff00567B)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: symmetricEdgeInsets(horizontal: 25, vertical: 0),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  verticalSpace(40),
                  CustomContainer(
                    width: double.infinity,
                    radiusCircular: 4,
                    backgroundColor: Color(0xffE0E0E0),
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    // borderColor: Colors.grey,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const TextWidget(
                              text: "Emp ID :",
                              textSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            horizontalSpace(10),
                            TextWidget(
                              text: CacheHelper.returnData(key: CacheKey.empId),
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
                              text: "Bus NO.:",
                              textSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            horizontalSpace(10),
                            const TextWidget(
                              text: "00013",
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
                              text: "Mada machine NO.:",
                              textSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            horizontalSpace(10),
                            const TextWidget(
                              text: "26548742",
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
                              text: "STC pay ID :",
                              textSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            horizontalSpace(10),
                            const TextWidget(
                              text: "0013",
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
                  CustomContainer(
                    width: double.infinity,
                    radiusCircular: 4,
                    backgroundColor: Color(0xffE0E0E0),
                    padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "Your Rate is :",
                          textSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        verticalSpace(16),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                  ),
                  verticalSpace(32),
                  Row(
                    children: [
                      TextWidget(
                        text: "Phone Number",
                        textSize: 15,
                        isTitle: true,
                        fontWeight: FontWeight.w600,
                      ),
                      horizontalSpace(10),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: StatefulBuilder(
                                  builder: (context1, setState) {
                                    return CustomContainer(
                                      height: 220,
                                      padding: symmetricEdgeInsets(
                                          horizontal: 10, vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TextWidget(
                                            text: "Update Phone Number",
                                            textSize: 15,
                                            isTitle: true,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          verticalSpace(20),
                                          Row(
                                            children: [
                                              CustomContainer(
                                                padding: symmetricEdgeInsets(
                                                    horizontal: 4),
                                                width: 72,
                                                height: 48,
                                                radiusCircular: 5,
                                                alignment: Alignment.center,
                                                backgroundColor:
                                                    Color(0xffE0E0E0),
                                                // borderColor: AppColor.borderBlue,
                                                onTap: () async {
                                                  // final code =
                                                  //     await countryPicker.showPicker(context: context);
                                                  // setState(() {
                                                  //   countryCode = code;
                                                  // });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomSizedBox(
                                                      width: 20,
                                                      height: 14,
                                                      child: countryCode != null
                                                          ? (countryCode!
                                                              .flagImage())
                                                          : const SizedBox(),
                                                    ),
                                                    horizontalSpace(2),
                                                    TextWidget(
                                                      text: countryCode != null
                                                          ? countryCode!
                                                              .dialCode
                                                          : '',
                                                      textSize: 14,
                                                      fontWeight:
                                                          MyFontWeight.regular,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              horizontalSpace(6),
                                              Expanded(
                                                  child: DefaultFormField(
                                                controller: phoneController,
                                                hintText: '545548879',
                                                keyboardType:
                                                    TextInputType.phone,
                                                padding: symmetricEdgeInsets(
                                                    horizontal: 15),
                                                textInputAction:
                                                    TextInputAction.done,
                                                letterSpacing: 3,
                                                textHeight: 0.8,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      11),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ))
                                            ],
                                          ),
                                          verticalSpace(20),
                                          DefaultButton(
                                            text: "Update",
                                            width: 150,
                                            onPressed: () {
                                              userDataProvider.phone =
                                                  phoneController.text;
                                              CacheHelper.saveData(
                                                  key: CacheKey.phoneNumber,
                                                  value: phoneController.text);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Material(
                          child: TextWidget(
                            text: "Change Phone Number",
                            textSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff006CB8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(14),
                  Row(
                    children: [
                      CustomContainer(
                        padding: symmetricEdgeInsets(horizontal: 4),
                        width: 72,
                        height: 45,
                        radiusCircular: 5,
                        alignment: Alignment.center,
                        backgroundColor: Color(0xffE0E0E0),
                        // borderColor: AppColor.borderBlue,
                        onTap: () async {
                          // final code =
                          //     await countryPicker.showPicker(context: context);
                          // setState(() {
                          //   countryCode = code;
                          // });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomSizedBox(
                              width: 20,
                              height: 14,
                              child: countryCode != null
                                  ? (countryCode!.flagImage())
                                  : const SizedBox(),
                            ),
                            horizontalSpace(2),
                            TextWidget(
                              text: countryCode != null
                                  ? countryCode!.dialCode
                                  : '',
                              textSize: 14,
                              fontWeight: MyFontWeight.regular,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(6),
                      Expanded(
                        child: CustomContainer(
                          backgroundColor: Color(0xffE0E0E0),
                          height: 45,
                          radiusCircular: 5,
                          padding: symmetricEdgeInsets(horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                            text: userDataProvider.phone!,
                          ),
                        ),
                      )
                    ],
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
