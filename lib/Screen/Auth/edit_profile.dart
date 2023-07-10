import 'dart:io';

import 'package:ashlife/controller/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import '../../widgets/form.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    emailController.text = authController.user.value.email.toString();
    nameController.text = authController.user.value.name.toString();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Edit profile"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  if (authController.isLoading.value) {
                    return;
                  }
                  if (nameController.text.isEmpty |
                      emailController.text.isEmpty) {
                    Get.snackbar(
                        'Error', 'Please fill all profile information');
                    return;
                  }

                  FocusScope.of(context).unfocus();
                  await authController.editUserInformation(
                      nameController.text, emailController.text);
                  Get.back();
                },
                child: const Icon(
                  Icons.save,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Container(
        color: const Color(0xff253890).withOpacity(0.4),
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color(0xff253890),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Obx(() {
                        String name = authController.user.value.name ?? 'A';
                        String avatar = authController.avatar.value;
                        if (avatar == '') {
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Text(
                              name[0],
                              style: const TextStyle(
                                  color: Color(0xff253890),
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        }
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(File(avatar)),
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Material(
                          color: Colors.lightBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: InkWell(
                            onTap: () async {
                              await authController.changeProfilePicture();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Center(
                                child: HeroIcon(
                                  HeroIcons.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                bool isLoading = authController.isLoading.value;
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return Column(
                  children: [
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
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
