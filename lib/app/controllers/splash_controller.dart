import 'package:ykapay/state/global.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController with GetTool {
  GetStorage box = GetStorage();

  RxBool isLoading = false.obs;

  GlobalState globalState = Get.put(GlobalState());
  GlobalState global = Get.find();

  @override
  void onInit() async {
    if (!box.hasData('token')) {
      await Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed('login');
      });
    } else {
      await Future.delayed(
        Duration(seconds: 1),
        () {
          Get.offAllNamed('bottom_menu');
        },
      );
    }

    super.onInit();
  }
}
