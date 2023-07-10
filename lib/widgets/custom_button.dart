import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final bool isLoading;
  final Function pressed;

  const CustomButton({
    super.key, required this.text, required this.textColor, required this.color, required this.pressed, required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: (){
          pressed();
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10
            )]
          ),
          child: isLoading ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
              ),
              const SizedBox(width: 15,),
              Text(
                "txt_loading".tr,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600
                ),
              )
            ]
          )
              : Text(
            text,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }
}



class CustomIconButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Function pressed;
  final IconData icon;
  final bool isLoading;

  const CustomIconButton({
    super.key, required this.text, required this.textColor, required this.color, required this.pressed, required this.icon, required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: (){
          pressed();
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10
            )]
          ),
          child: isLoading ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
                ),
                const SizedBox(width: 15,),
                Text(
                  "txt_loading".tr,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600
                  ),
                )
              ]
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white,),
              const SizedBox(width: 5,),
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],)
        ),
      ),
    );
  }
}
