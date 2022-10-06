import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:ykapay/config/palette.dart';

class SmartRefresherSuccess extends StatelessWidget {
  SmartRefresherSuccess({
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
      complete: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.check, color: Color(0xff67c23a), size: 18),
          SizedBox(width: 5),
          Text(
            message ?? 'requestspage_refresh_list_conpleted'.tr,
            style: Palette.textStyle().copyWith(color: Color(0xff67c23a)),
          ),
        ],
      ),
    );
  }
}
