import 'package:get/get.dart';
import './../../app/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(),);
  }
}
