import 'package:ashlife/navigation/bottom_navigation.dart';
import 'package:ashlife/navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void notificationNavigation(Map<String, dynamic> payload) {
    if (payload['to'] == "main") {
      // Navigator.of(navigatorKey.currentContext!).push(
      //     MaterialPageRoute(builder: (context) => const BottomNavigation()));
      Get.to(const BottomNavigation());
    }
  }
}
