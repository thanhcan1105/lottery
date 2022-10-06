import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidget {
  static progressIndicator() {
    Get.dialog(
        Center(
          child: SizedBox(height: 70, width: 70, child: CupertinoActivityIndicator()),
        ),
        barrierDismissible: false);
  }
}
