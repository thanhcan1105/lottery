import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ykapay/config/palette.dart';

class MyButtonSubmit extends StatelessWidget {
  const MyButtonSubmit({
    Key? key,
    required this.onPressed,
    required this.label,
    this.submiting = false,
    this.fontSize = 18,
    this.textColor = Colors.white,
    this.height = 50,
    this.backgroundColor,
    this.radius = 10,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final bool submiting;
  final double fontSize;
  final Color textColor;
  final double height;
  final Color? backgroundColor;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      minWidth: Get.width * 0.95,
      height: height,
      onPressed: onPressed,
      child: submiting
          ? CircularProgressIndicator(backgroundColor: Colors.white)
          : Text(
              label,
              style: Palette.textStyle().copyWith(fontSize: fontSize),
            ),
      color: backgroundColor ?? Palette.primaryColor,
      textColor: textColor,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.white,
      splashColor: Colors.blue,
    );
  }
}
