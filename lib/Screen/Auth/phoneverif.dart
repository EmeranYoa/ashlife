import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ashlife/Screen/Auth/new_password.dart';
import 'package:ashlife/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Phoneverif extends StatefulWidget {
  final String title;
  final String phoneNumber;
  final String nextRoute;
  final String type;
  const Phoneverif({super.key, required this.title, required this.phoneNumber, required this.nextRoute, required this.type});

  @override
  State<Phoneverif> createState() => _PhoneverifState();
}

class _PhoneverifState extends State<Phoneverif> {
  bool isLoading = false;
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<void> submitOtp() async {
      setState(() {
        isLoading = true;
      });
      if(pinController.text.isEmpty){
        Get.snackbar('Error', 'Please Enter verification code');
        setState(() {
          isLoading = false;
        });
        return;
      }

      if(pinController.text.length < 6){
        Get.snackbar('Error', 'Please Enter correct code');
        setState(() {
          isLoading = false;
        });
        return;
      }

      if(widget.type == 'register'){
        try{
          await Amplify.Auth.confirmSignUp(
              username: widget.phoneNumber,
              confirmationCode: pinController.text);
          setState(() {
            isLoading = false;
          });
          Get.toNamed(widget.nextRoute);
        } on AuthException catch(e){
          setState(() {
            isLoading = false;
          });
          Get.snackbar('Error', e.message);
        }
        return;
      }
      Get.to(NewPassword(ping: pinController.text, username: widget.phoneNumber),
          transition: Transition.rightToLeft, duration: const Duration(seconds: 1));
      return;
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
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children:  <Widget>[
                          const SizedBox(height: 100,),
                          Text(
                            "Enter verification code send at ${widget.phoneNumber}",
                            style:  const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15,),
                          Pinput(
                            controller: pinController,
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            length: 6,
                            defaultPinTheme: PinTheme(
                              width: 50,
                              height: 50,
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                              )
                            ),
                            onCompleted: (pin) => print(pin),
                          ),
                          const SizedBox(height: 15,),
                          CustomButton(
                            text: 'Verify now',
                            textColor: Colors.white,
                            color: const Color(0xff253890),
                            isLoading: isLoading,
                            pressed: (){
                              submitOtp();
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextLink(
                            text: "you did not receive the code ?",
                            textLink: "resend",
                            pressed: (){
                              if (kDebugMode) {
                                print('register link pressed');
                              }
                              Get.toNamed("/register");
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

class CodeDigitInputField extends StatelessWidget {
  const CodeDigitInputField({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0.2, 0.0)
              )
            ]
          ),
          width: (size.width / 6) - 20,
          height: 40,
          child:  const TextField(
            style:  TextStyle(
              color: Colors.black87,
              fontSize: 30
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0.2, 0.0)
              )
            ]
          ),
          width: (size.width / 6) - 20,
          height: 40,
          child:  const TextField(
            style:  TextStyle(
              color: Colors.black87,
              fontSize: 30
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0.2, 0.0)
              )
            ]
          ),
          width: (size.width / 6) - 20,
          height: 40,
          child:  const TextField(
            style:  TextStyle(
              color: Colors.black87,
              fontSize: 30
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0.2, 0.0)
              )
            ]
          ),
          width: (size.width / 6) - 20,
          height: 40,
          child:  const TextField(
            style:  TextStyle(
              color: Colors.black87,
              fontSize: 30
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0.2, 0.0)
              )
            ]
          ),
          width: (size.width / 6) - 20,
          height: 40,
          child:  const TextField(
            style:  TextStyle(
              color: Colors.black87,
              fontSize: 30
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0.2, 0.0)
              )
            ]
          ),
          width: (size.width / 6) - 20,
          height: 40,
          child:  const TextField(
            style:  TextStyle(
              color: Colors.black87,
              fontSize: 30
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}