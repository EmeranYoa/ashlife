import 'package:ashlife/Screen/account_screen.dart';
import 'package:ashlife/Screen/home_screen.dart';
import 'package:ashlife/Screen/subscription_screen.dart';
import 'package:ashlife/Screen/upload_screen.dart';
import 'package:ashlife/controller/navigation.controller.dart';
import 'package:ashlife/controller/upload.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  NavigationController navigationController = Get.put(NavigationController());

  final pages = [
    const HomeScreen(),
    const UploadScreen(),
    const AccountScreen()
  ];

  void onTap(int index) {
    navigationController.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    UploadController controller = Get.put(UploadController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(() => pages[navigationController.currentIndex.value]),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                iconSize: 30,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey.withOpacity(0.5),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedFontSize: 0,
                selectedFontSize: 0,
                elevation: 0,
                currentIndex: navigationController.currentIndex.value,
                onTap: onTap,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: HeroIcon(HeroIcons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Upload',
                    icon: HeroIcon(HeroIcons.rectangleStack),
                  ),
                  BottomNavigationBarItem(
                    label: 'Account',
                    icon: HeroIcon(HeroIcons.user),
                  ),
                ]),
          )),
    );
  }
}
