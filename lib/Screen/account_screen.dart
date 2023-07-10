import 'dart:io';

import 'package:ashlife/Screen/Auth/changePassword.dart';
import 'package:ashlife/Screen/Auth/edit_profile.dart';
import 'package:ashlife/Screen/Auth/login.dart';
import 'package:ashlife/Screen/Auth/my_subscription.dart';
import 'package:ashlife/Screen/language_screen.dart';
import 'package:ashlife/controller/auth.controller.dart';
import 'package:ashlife/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isSignOut = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    AuthService authService = Get.put(AuthService());

    Future<void> signOutCurrentUser() async {
      if (isSignOut) {
        return;
      }
      setState(() {
        isSignOut = true;
      });
      bool rst = await authService.signOutCurrentUser();
      if (rst) {
        setState(() {
          isSignOut = false;
        });
        Get.offAll(const Login());
        return;
      }
      setState(() {
        isSignOut = false;
      });
      return;
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xff253890),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color(0xff253890),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('txt_account'.tr, style: const TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),),
                    const SizedBox(height: 15,),
                    Row(
                      children: <Widget>[
                        Obx(() {
                          String name = Get
                              .find<AuthController>()
                              .user
                              .value
                              .name ?? 'A';
                          String avatar = Get
                              .find<AuthController>()
                              .avatar
                              .value;
                          if (avatar == '') {
                            return CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Obx(() {
                                String name = Get
                                    .find<AuthController>()
                                    .user
                                    .value
                                    .name ?? 'a';
                                return Text(
                                  name[0],
                                  style: const TextStyle(
                                      color: Color(0xff253890),
                                      fontWeight: FontWeight.w600),
                                );
                              }),
                            );
                          }
                          return CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(avatar)),
                          );
                        }),

                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Obx(() {
                              String name = Get
                                  .find<AuthController>()
                                  .user
                                  .value
                                  .name ?? '';
                              return Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              );
                            }),
                            Obx(() {
                              String email = Get
                                  .find<AuthController>()
                                  .user
                                  .value
                                  .email ?? '';
                              return Text(
                                email,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Material(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Get.to(const MySubscription(),
                              duration: const Duration(milliseconds: 800),
                              transition: Transition.rightToLeft);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const HeroIcon(HeroIcons.wallet),
                                  const SizedBox(width: 5,),
                                  Text('txt_my_balance'.tr,)
                                ],
                              ),),
                              const HeroIcon(HeroIcons.chevronRight),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Material(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Get.to(const EditProfile(),
                              duration: const Duration(milliseconds: 800),
                              transition: Transition.rightToLeft);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const HeroIcon(HeroIcons.pencilSquare),
                                  const SizedBox(width: 5,),
                                  Text('txt_edit_prof'.tr,)
                                ],
                              ),),
                              const HeroIcon(HeroIcons.chevronRight),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Material(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Get.to(const ChangePassword(),
                              duration: const Duration(milliseconds: 800),
                              transition: Transition.rightToLeft);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const HeroIcon(HeroIcons.key),
                                  const SizedBox(width: 5,),
                                  Text('txt_change_pass'.tr,)
                                ],
                              ),),
                              const HeroIcon(HeroIcons.chevronRight),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Material(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () =>
                            Get.to(const LanguageScreen(),
                                duration: const Duration(milliseconds: 800),
                                transition: Transition.rightToLeft),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const HeroIcon(HeroIcons.language),
                                  const SizedBox(width: 5,),
                                  Text('txt_change_lang'.tr,)
                                ],
                              ),),
                              const HeroIcon(HeroIcons.chevronRight),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                color: Colors.redAccent,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: InkWell(
                  onTap: () => signOutCurrentUser(),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: isSignOut ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            height: 20, width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2,)),
                        const SizedBox(width: 5,),
                        Text(
                          "txt_loading".tr, style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),)
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const HeroIcon(
                          HeroIcons.arrowLeftOnRectangle, color: Colors.white,),
                        const SizedBox(width: 5,),
                        Text('sign_out'.tr, style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
