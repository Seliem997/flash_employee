import 'package:flash_employee/services/authentication_service.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/ui/widgets/custom_container.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/font_styles.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/loginModel.dart';
import '../../../providers/user_provider.dart';
import '../../home/home_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/eye_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/spaces.dart';
import 'dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationService authenticationService = AuthenticationService();
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  var userName = '';
  var password = '';

  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeViewStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: symmetricEdgeInsets(horizontal: 24, vertical: 23),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextWidget(
                    text: 'Login',
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.bold,
                  ),
                  verticalSpace(56),
                  CustomSizedBox(
                    width: 133,
                    height: 122,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                  verticalSpace(54),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Username',
                        fontWeight: MyFontWeight.medium,
                        textSize: MyFontSize.size16,
                        color: const Color(0xFF272727),
                      ),
                      verticalSpace(4),
                      DefaultFormField(
                        hintText: 'User Name',
                        controller: userNameController,
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
                          _formKey.currentState!.validate();
                        },
                      ),
                      verticalSpace(38),
                      TextWidget(
                        text: 'Password',
                        fontWeight: MyFontWeight.medium,
                        textSize: MyFontSize.size16,
                        color: const Color(0xFF272727),
                      ),
                      verticalSpace(4),
                      DefaultFormField(
                        hintText: 'Password',
                        controller: passwordController,
                        isPassword: _obscureText,
                        textInputAction: TextInputAction.done,
                        prefixIcon: const DecorationImage(
                            image: AssetImage("assets/images/password.png"),
                            fit: BoxFit.cover),
                        suffixIcon: EyeWidget(
                            onTap: () => changeViewStatus, show: _obscureText),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please Enter Your Password';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          password = value;
                          _formKey.currentState!.validate();
                        },
                      ),
                      verticalSpace(8),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const ProblemSigning();
                                },
                              );
                            },
                            child: TextWidget(
                              text: 'Problem Signing?',
                              textSize: MyFontSize.size14,
                              fontWeight: MyFontWeight.regular,
                              color: const Color(0xFF0084B7),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ForgetPassword();
                                },
                              );
                            },
                            child: TextWidget(
                              text: 'Forgot password?',
                              textSize: MyFontSize.size14,
                              fontWeight: MyFontWeight.regular,
                              color: const Color(0xFF0084B7),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(80),
                      DefaultButton(
                        text: 'Log in',
                        fontWeight: MyFontWeight.bold,
                        fontSize: MyFontSize.size18,
                        height: 48,
                        width: double.infinity,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            AppLoader.showLoader(context);
                            await authenticationService
                                .signIn(userNameController.text,
                                    passwordController.text)
                                .then((value) {
                              AppLoader.stopLoader();

                              if (value.status == Status.success) {
                                final userData = (value.data as UserData?);
                                if ((value.data as UserData?) != null) {
                                  userDataProvider.phone = userData!.phone;
                                  userDataProvider.userName = userData.name;
                                  userDataProvider.userImage = userData.image;
                                  userDataProvider.email = userData.email;
                                  userDataProvider.duties = userData.duties;
                                }

                                navigateAndFinish(context, HomeScreen());
                              } else {
                                CustomSnackBars.somethingWentWrongSnackBar(
                                    context);
                              }
                            });
                          }
                        },
                      ),
                      verticalSpace(12),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
