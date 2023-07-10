import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewPassword extends StatefulWidget {
  final String username;
  final String ping;
  const NewPassword({super.key, required this.username, required this.ping});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final cpasswordController = TextEditingController();
    final passwordController = TextEditingController();

    Future<void> changePass() async {
      setState(() {
        isLoading = true;
      });
      if(cpasswordController.text == "" || passwordController.text == ""){
        Get.snackbar('Error', "Please fill all data");
        setState(() {
          isLoading = false;
        });
        return;
      }
      if(cpasswordController.text != passwordController.text){
        Get.snackbar('Error', "Password don't match !");
        setState(() {
          isLoading = false;
        });
        return;
      }
      try{
        await Amplify.Auth.confirmResetPassword(
            username: widget.username,
            newPassword: passwordController.text,
            confirmationCode: widget.ping
        );
        Get.snackbar('Info', "Your password has been reset, you can login now to your account");
        setState(() {
          isLoading = false;
        });
        Get.toNamed('/login');
      } on AuthException catch(e){
        setState(() {
          isLoading = false;
        });
        Get.snackbar('Error', e.message);
      }

    }
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
                    const SizedBox(height: 10,),
                    const Text(
                      "New Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children:  <Widget>[
                          const SizedBox(height: 50,),

                          PasswordField(
                            text: "Password",
                            hintText: "New Password",
                            controller: passwordController,
                          ),
                          const SizedBox(height: 10,),
                          PasswordField(
                            text: "Confirm password",
                            hintText: "Confirm your password",
                            controller: cpasswordController,
                          ),
                          const SizedBox(height: 15,),
                          CustomButton(
                            text: 'Change',
                            textColor: Colors.white,
                            color: const Color(0xff253890),
                            isLoading: isLoading,
                            pressed: (){
                              changePass();
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextLink(
                            text: "you did not receive the code ?",
                            textLink: "resend",
                            pressed: (){
                              Get.toNamed("/login");
                            },
                          )
                        ],
                      ),
                    )
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );

  }
}