import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:ashlife/Screen/Auth/login.dart';
import 'package:ashlife/amplifyconfiguration.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/models/ModelProvider.dart';
import 'package:ashlife/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userIsAuth = false;
  AuthController authController = Get.put(AuthController());

  @override
  initState() {
    super.initState();
    _checkIfAuthenticated();
    _firstRunCheck();
  }

  Future<void> _checkIfAuthenticated() async {
    final isAuthenticated = await authController.checkAuthenticateUser();
    setState(() {
      userIsAuth = isAuthenticated;
    });
  }

  Future<void> _firstRunCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirst = prefs.getBool('isFirstRun') ?? true;
    if (isFirst) {
      prefs.setBool('isFirstRun', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xff253890),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: AnimatedSplashScreen(
        splash: 'assets/logo/brand.png',
        duration: 1500,
        nextScreen: userIsAuth ? const BottomNavigation() : const Login(),
        nextRoute: userIsAuth ? '/main' : '/login',
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xff253890),
      ),
    );
  }
}
