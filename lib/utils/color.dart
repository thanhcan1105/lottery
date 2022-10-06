import 'package:flutter/material.dart';

class ColorFormat {
  static String colorToString(Color color) {
    String colorString = color.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return valueString;
  }

  static Color stringToColor(String color) {
    int value = int.parse(color, radix: 16);
    return new Color(value);
  }

  static Color requestTypeColor(int index) {
    switch (index) {
      case 1:
        return Colors.cyan;
        break;
      case 2:
        return Colors.purple;
        break;
      case 3:
        return Colors.pink;
        break;
      case 4:
        return Colors.blueAccent;
      case 5:
        return Colors.amberAccent;

        break;
      default:
        return Colors.purpleAccent;
    }
  }
  static Color? BGColors = Colors.grey[200];
}
