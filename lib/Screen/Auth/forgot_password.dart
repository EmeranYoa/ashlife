import 'package:ashlife/Screen/Auth/phoneverif.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false;
  final phoneNumberController = TextEditingController();
  final AuthService authService = Get.put(AuthService());

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
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/logo/brand.png',
                      height: size.height * 0.15,
                      width: size.width * 0.25,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'forgot_pass'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: PhoneNumberInput(controller: phoneNumberController),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: CustomButton(
                            text: 'lbl_send'.tr,
                            textColor: Colors.white,
                            color: const Color(0xff253890),
                            isLoading: isLoading,
                            pressed: () async {
                              if (phoneNumberController.text.isEmpty) {
                                Get.snackbar('Error', "fill the phone number");
                                return;
                              }
                              bool send = await authService.sendRecoveryRequest(phoneNumberController.text);
                              if (send) {
                                Get.to(Phoneverif(title: 'Code verification', phoneNumber: phoneNumberController.text, nextRoute: '/new_password', type: 'forgot',), transition: Transition.fade, duration: const Duration(seconds: 1));
                              }
                            },
                          ),
                        ),
                        TextLink(
                          text: "remember_pass".tr,
                          textLink: "link_click_here".tr,
                          pressed: () {
                            if (kDebugMode) {
                              print('Remember your password link pressed');
                            }
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}