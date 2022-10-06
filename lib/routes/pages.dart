import 'package:ykapay/app/screens/bottom_menu/bottom_menu.dart';
import 'package:ykapay/app/screens/home/home_screen.dart';

import './../app/bindings/home_binding.dart';
import './../app/screens/splash/splash_screen.dart';
import './../app/bindings/splash_binding.dart';
import 'package:get/get.dart';
part './routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BOTTOMMENU,
      page: () => BottomMenu(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
    ),
  ];
}
