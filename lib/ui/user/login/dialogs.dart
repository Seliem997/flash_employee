import 'package:flash_employee/services/authentication_service.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/font_styles.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_container.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/spaces.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: CustomContainer(
          width: 321,
          height: 280,
          radiusCircular: 12,
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 38),
          child: Column(
            children: [
              TextWidget(
                text: 'Forgot password',
                fontWeight: MyFontWeight.bold,
                textSize: 17,
              ),
              verticalSpace(35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Email / Username',
                    fontWeight: MyFontWeight.medium,
                    textSize: 14,
                    color: const Color(0xFF545454),
                  ),
                  verticalSpace(4),
                  DefaultFormField(
                    hintText: 'Enter your username / email',
                    // controller: userNameController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const DecorationImage(
                        image: AssetImage("assets/images/profile_icon.png"),
                        fit: BoxFit.cover),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please Enter Your User Name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      userName = value;
                      // _formKey.currentState!.validate();
                    },
                  ),
                ],
              ),
              Spacer(),
              DefaultButton(
                text: 'Send New Password',
                fontWeight: MyFontWeight.bold,
                fontSize: MyFontSize.size16,
                height: 40,
                width: 225,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    AppLoader.showLoader(context);
                    AuthenticationService auth = AuthenticationService();
                    await auth.forgotPassword(userName).then((value) {
                      AppLoader.stopLoader();
                      if (value.status == Status.success) {
                        CustomSnackBars.successSnackBar(
                            context, "New Password sent successfully");
                      } else {
                        CustomSnackBars.somethingWentWrongSnackBar(context);
                      }
                      Navigator.pop(context);
                    });
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

class ProblemSigning extends StatelessWidget {
  const ProblemSigning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainer(
        width: 321,
        height: 210,
        radiusCircular: 12,
        padding: symmetricEdgeInsets(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            TextWidget(
              text: 'Problem Signing',
              fontWeight: MyFontWeight.bold,
              textSize: 15,
            ),
            verticalSpace(23),
            TextWidget(
              text: 'Contact your direct Manager ',
              fontWeight: MyFontWeight.medium,
              textSize: MyFontSize.size15,
              color: const Color(0xFF3F3F3F),
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
                      image: AssetImage("assets/images/telephone.png"),
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
            verticalSpace(24),
            DefaultButton(
              text: 'OK',
              fontWeight: MyFontWeight.bold,
              fontSize: MyFontSize.size16,
              height: 35,
              width: 225,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
