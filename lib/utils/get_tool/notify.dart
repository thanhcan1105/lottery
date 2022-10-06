part of 'get_tool.dart';

class NotifyModule {
  error({String? title, String? message, int timeout = 5000}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      title!,
      message!,
      backgroundColor: Color(0xfffef0f0),
      colorText: Color(0xfff56c6c),
      duration: Duration(milliseconds: timeout),
    );
  }

  success({String? title, String? message, int timeout = 5000, position = SnackPosition.TOP}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      title!,
      message!,
      backgroundColor: Color(0xfff0f9eb),
      colorText: Color(0xff67c23a),
      duration: Duration(milliseconds: timeout),
      snackPosition: position
    );
  }

  warning({String? title, String? message, int timeout = 5000}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      title!,
      message!,
      backgroundColor: Color(0xfffdf6ec),
      colorText: Color(0xffe6a23c),
      duration: Duration(milliseconds: timeout),
    );
  }

  info({String? title, String? message, int timeout = 5000}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      title!,
      message!,
      backgroundColor: Color(0xfffef0f0),
      colorText: Color(0xff909399),
      duration: Duration(milliseconds: timeout),
    );
  }
}
