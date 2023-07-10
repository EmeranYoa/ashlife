import 'dart:io';

import 'package:ashlife/services/auth.service.dart';
import 'package:ashlife/services/cache.service.dart';
import 'package:ashlife/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController cNewPasswordController = TextEditingController();
    AuthService authService = Get.put(AuthService());
    bool loading = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff253890),
          title: const Text('Change password'),
          centerTitle: true,

          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    if (loading){
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    if(oldPasswordController.text.isEmpty | newPasswordController.text.isEmpty| cNewPasswordController.text.isEmpty){
                      Get.snackbar(
                        'Error',
                        'Please fill password information',
                      );
                      return;
                    }
                    if(newPasswordController.text != cNewPasswordController.text){
                      Get.snackbar(
                        'Error',
                        "Passwords don't match",
                      );
                      return;
                    }

                    setState(() {
                      loading = true;
                    });
                    await authService.changePassword(newPasswordController.text, oldPasswordController.text);
                    setState(() {
                      loading = false;
                    });
                    Get.back();
                  },
                  child: const Icon(
                    Icons.save,
                    size: 26.0,
                  ),
                )
            ),
          ],
        ),
        body: Padding(
      padding: EdgeInsets.all(16),
      child: loading ?
        const Center(child: SizedBox(child: CircularProgressIndicator(color:  Color(0xff253890),),),)
          : Column(
        children: [
          PasswordField(
            text: "lbl_oldpassword".tr,
            hintText: "lbl_oldpassword".tr,
            controller: oldPasswordController,
          ),
          const SizedBox(height: 10,),
          PasswordField(
            text: "lbl_password".tr,
            hintText: "lbl_password".tr,
            controller: newPasswordController,
          ),
          const SizedBox(height: 10,),
          PasswordField(
            text: "lbl_cpassword".tr,
            hintText: "lbl_cpassword".tr,
            controller: cNewPasswordController,
          ),
          const SizedBox(height: 10,),
        ],
      ),
    ),);
  }
}
