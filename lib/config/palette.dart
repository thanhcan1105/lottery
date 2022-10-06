import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[primaryColor, secondColor],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static LinearGradient gradient = LinearGradient(
    colors: [Colors.blue, Colors.cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final Color primaryColor = Color(0xff0070ab);

  static final Color errorColor = Colors.red;

  static final Color lightColor = Colors.grey;

  static final Color secondColor = Color(0xff01a0e3);

  static final Color colorCyan = Colors.cyan;

  static final Color colorTextOnPink = Colors.yellowAccent;

  static final Color selectedItemColor = Colors.orange;

  static final Color unselectedItemColor = Colors.grey;

  static final Color iconActionColor = Colors.black54;

  static final Color textColorLight = Colors.white;

  static TextStyle textTitle1() => Palette.textStyle().copyWith(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle textStyle() {
    return GoogleFonts.montserrat();
  }

  static TextStyle textTitle2() => Palette.textStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle titleProduct() => Palette.textStyle().copyWith(
        fontSize: 16,
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
      );
  static TextStyle smallText() => Palette.textStyle().copyWith(
        fontSize: 14,
        color: Colors.grey,
        //fontWeight: FontWeight.bold,
      );
}
