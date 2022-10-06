import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ykapay/app/bindings/home_binding.dart';
import 'package:ykapay/app/screens/home/home_screen.dart';
import 'package:ykapay/utils/notification_service.dart';

import 'config/palette.dart';
import 'lang/localization.dart';
import 'routes/pages.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  PushNotificationsManager().init();
  await GetStorage.init();
  Future.delayed(
    Duration(milliseconds: 200),
    () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    },
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.full,
      initialBinding: HomeBinding(),
      initialRoute: Routes.HOME,
      getPages: AppPages.pages,
      home: HomeScreen(),
      theme: ThemeData(
        fontFamily: 'roboto',
        primaryColor: Palette.primaryColor,
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    ),
  );
}
