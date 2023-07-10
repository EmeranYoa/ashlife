import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:  AssetImage('assets/img/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
