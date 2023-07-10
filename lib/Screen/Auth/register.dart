import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/Screen/Auth/phoneverif.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/widgets/image.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isSignUpComplete = false;
  bool isLoadingSignup = false;
  bool isLoading = false;
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final sexeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    nameController.dispose();
    sexeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();

    super.dispose();
  }

  Future<void> signUpUser() async {
    try {
      setState(() {
        isLoadingSignup = true;
      });
      if (emailController.text.isEmpty ||
          nameController.text.isEmpty ||
          sexeController.text.isEmpty ||
          phoneNumberController.text.isEmpty ||
          passwordController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill all data');
        setState(() {
          isLoadingSignup = false;
          isSignUpComplete = false;
        });
        return;
      }

      if (passwordController.text != cpasswordController.text) {
        Get.snackbar('Error', "The password doesn't not match !!!");
        setState(() {
          isLoadingSignup = false;
          isSignUpComplete = false;
        });
        return;
      }

      if (!EmailValidator.validate(emailController.text)) {
        Get.snackbar('Error', "Please fill valid email address !!");
        setState(() {
          isLoadingSignup = false;
          isSignUpComplete = false;
        });
        return;
      }

      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: emailController.text,
        CognitoUserAttributeKey.name: nameController.text,
        CognitoUserAttributeKey.gender: sexeController.text,
        CognitoUserAttributeKey.phoneNumber: phoneNumberController.text,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: phoneNumberController.text,
        password: passwordController.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );

      final user = User(
          name: nameController.text,
          phone: phoneNumberController.text,
          email: emailController.text);
      await Amplify.DataStore.save(user);

      setState(() {
        isLoadingSignup = false;
        isSignUpComplete = result.isSignUpComplete;
      });

      Get.to(
          Phoneverif(
            title: 'Phone number verification',
            phoneNumber: phoneNumberController.text,
            nextRoute: '/login',
            type: 'register',
          ),
          transition: Transition.fade,
          duration: const Duration(seconds: 1));
    } on AmplifyException catch (e) {
      setState(() {
        isLoadingSignup = false;
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
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Stack(
        children: <Widget>[
          const AuthBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Column(children: <Widget>[
              AshlifeImage(
                  height: size.height * 0.15,
                  width: size.width * 0.25,
                  path: 'assets/logo/brand.png'),
              const SizedBox(
                height: 10,
              ),
              Text(
                'sign_up'.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    PhoneNumberInput(
                      controller: phoneNumberController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      text: 'lbl_name'.tr,
                      hintText: "lbl_name".tr,
                      icon: Icons.person_2_sharp,
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      text: 'lbl_email'.tr,
                      hintText: "lbl_email".tr,
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordField(
                      text: "lbl_password".tr,
                      hintText: "lbl_password".tr,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordField(
                      text: "lbl_cpassword".tr,
                      hintText: "lbl_cpassword".tr,
                      controller: cpasswordController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: <Widget>[
                      LiteRollingSwitch(
                        value: true,
                        textOn: 'txt_male'.tr,
                        textOff: 'txt_female'.tr,
                        colorOn: const Color(0xff253890),
                        textOffColor: Colors.white,
                        textOnColor: Colors.white,
                        colorOff: const Color(0xff050B29),
                        iconOn: Icons.male,
                        iconOff: Icons.female,
                        textSize: 16.0,
                        onChanged: (bool state) {
                          //Use it to manage the different states
                          if (kDebugMode) {
                            print('Current State of SWITCH IS: $state');
                          }
                          if (state) {
                            sexeController.text = "male";
                          } else {
                            sexeController.text = "female";
                          }
                        },
                        onDoubleTap: () {
                          //log here
                        },
                        onTap: () {
                          //log here
                        },
                        onSwipe: () {
                          //log here
                        },
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'sign_up'.tr,
                      textColor: Colors.white,
                      color: const Color(0xff253890),
                      isLoading: isLoadingSignup,
                      pressed: () {
                        signUpUser();
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
                      text: 'fb_signup'.tr,
                      textColor: Colors.white,
                      color: const Color(0xff253890),
                      icon: Icons.facebook,
                      isLoading: isLoading,
                      pressed: () {
                        if (kDebugMode) {
                          print("Sign in with Facebook button pressed");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextLink(
                      text: "have_account".tr,
                      textLink: 'sign_in'.tr,
                      pressed: () {
                        if (kDebugMode) {
                          print('Sign in link pressed');
                        }
                        Get.back();
                      },
                    )
                  ]),
                ),
              ))
            ])),
          )
        ],
      ),
    );
  }
}
