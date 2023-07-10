import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String text;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  const InputField(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.icon,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
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
                    offset: Offset(0.2, 0.0))
              ]),
          height: 50,
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  icon,
                  color: const Color(0xff253890),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;

  const PasswordField(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.controller})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
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
                    offset: Offset(0.2, 0.0))
              ]),
          height: 50,
          child: TextField(
            controller: widget.controller,
            obscureText: !showPass,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xff253890),
                ),
                suffixIcon: IconButton(
                    iconSize: 24,
                    icon: showPass
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color(0xff253890),
                          )
                        : const Icon(
                            Icons.remove_red_eye_rounded,
                            color: Color(0xff253890),
                          ),
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    }),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }
}

class TextLink extends StatelessWidget {
  final String text;
  final String textLink;
  final Function pressed;

  const TextLink(
      {super.key,
      required this.text,
      required this.textLink,
      required this.pressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              pressed();
            },
            child: Text(
              textLink,
              style: const TextStyle(
                  color: Color(0xff253890),
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ))
      ],
    );
  }
}

class OrSeparator extends StatelessWidget {
  const OrSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(
              color: Colors.white54,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'or'.tr,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 5,
          ),
          const Expanded(
            child: Divider(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'lbl_phone_number'.tr,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
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
                    offset: Offset(0.2, 0.0))
              ]),
          height: 50,
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              if (kDebugMode) {
                print(number.phoneNumber);
              }
              controller.text = number.phoneNumber!;
            },
            selectorConfig: const SelectorConfig(
              leadingPadding: 10,
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onSaved: (PhoneNumber number) {
              if (kDebugMode) {
                print('On Saved: $number');
              }
            },
            countrySelectorScrollControlled: true,
            inputDecoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Phone number',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        )
      ],
    );
  }
}
