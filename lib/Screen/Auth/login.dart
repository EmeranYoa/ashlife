import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/widgets/image.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool isLoadingFb = false;
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signInUser() async {
    if (phoneNumberController.text.isEmpty | passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill authenticate information',
      );
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });

      FocusScope.of(context).unfocus();

      await Amplify.Auth.signIn(
          username: phoneNumberController.text,
          password: passwordController.text);

      setState(() {
        isLoading = false;
      });
      Get.offAllNamed('/main');
    } on AuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
        'Error',
        e.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Stack(
        children: <Widget>[
          const AuthBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  AshlifeImage(
                    path: 'assets/logo/brand.png',
                    height: size.height * 0.15,
                    width: size.width * 0.25,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'sign_in'.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Column(children: <Widget>[
                          PhoneNumberInput(controller: phoneNumberController),
                          const SizedBox(
                            height: 10,
                          ),
                          PasswordField(
                            text: "lbl_password".tr,
                            hintText: "lbl_password".tr,
                            controller: passwordController,
                          ),
                          TextLink(
                            text: 'forgot'.tr,
                            textLink: 'link_click_here'.tr,
                            pressed: () {
                              if (kDebugMode) {
                                print('Forgot password  link pressed');
                              }
                              Get.toNamed("/forgot");
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            text: 'sign_in'.tr,
                            textColor: Colors.white,
                            color: const Color(0xff253890),
                            isLoading: isLoading,
                            pressed: () {
                              signInUser();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const OrSeparator(),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomIconButton(
                            text: 'fb_sign'.tr,
                            textColor: Colors.white,
                            color: const Color(0xff253890),
                            icon: Icons.facebook,
                            isLoading: isLoadingFb,
                            pressed: () {
                              if (kDebugMode) {
                                print("Sign in with Facebook button pressed");
                              }
                            },
                          ),
                          TextLink(
                            text: "dont_have_account".tr,
                            textLink: "sign_up".tr,
                            pressed: () {
                              if (kDebugMode) {
                                print('register link pressed');
                              }
                              Get.toNamed("/register");
                            },
                          ),
                        ])
                      ],
                    ),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
