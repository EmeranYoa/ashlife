import 'package:ashlife/Screen/Auth/forgot_password.dart';
import 'package:ashlife/Screen/Auth/login.dart';
import 'package:ashlife/Screen/Auth/new_password.dart';
import 'package:ashlife/Screen/Auth/phoneverif.dart';
import 'package:ashlife/Screen/Auth/register.dart';
import 'package:ashlife/Screen/image_screen.dart';
import 'package:ashlife/Screen/splash_screen.dart';
import 'package:ashlife/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    //Route<dynamic> generateRoute(RouteSettings settings)
    switch (settings.name) {
      case '/':
        return GetPageRoute(routeName: '/', page: () => const SplashScreen());
      case '/login':
        return GetPageRoute(routeName: '/login', page: () => const Login(),transition: Transition.leftToRight, transitionDuration: const Duration(seconds: 1));
      case '/register':
        return GetPageRoute(routeName: '/register', page: () => const Register(),transition: Transition.rightToLeft, transitionDuration: const Duration(seconds: 1));
      case '/forgot':
        return GetPageRoute(routeName: '/forgot', page: () => const ForgotPassword(),transition: Transition.rightToLeft, transitionDuration: const Duration(seconds: 1));
      case '/ImageGenerated':
        return GetPageRoute(routeName: '/ImageGenerated', page: () => const ImageGenerated(),transition: Transition.rightToLeft, transitionDuration: const Duration(seconds: 1));
      case '/main':
        return GetPageRoute(routeName: '/main', page: () => const BottomNavigation(),transition: Transition.fade, transitionDuration: const Duration(seconds: 1));
      default:
    }
    return GetPageRoute(page: ()=> const Scaffold(
      body: Text('no route define'),
      )
    );
  }
}