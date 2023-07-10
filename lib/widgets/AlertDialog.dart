import 'package:flutter/material.dart';

class AlertDialog extends StatelessWidget {
  const AlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white
      ),
      height: 200,
      width: 200,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Hello'),
      ),
    );
  }
}
