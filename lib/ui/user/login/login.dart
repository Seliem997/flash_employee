import 'package:flash_employee/ui/widgets/custom_container.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/utils/font_styles.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: symmetricEdgeInsets(horizontal: 24,vertical: 23),
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
                        hintText: 'password',
                        controller: passwordController,
                        isPassword: _obscureText,
                        textInputAction: TextInputAction.done,
                        suffixIcon: EyeWidget(onTap: () => changeViewStatus),
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
                                  return const ForgetPassword();
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
                        onPressed: () {
                          navigateTo(context, const HomeScreen(),);
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
