import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ykapay/constants.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:ykapay/utils/http_service_core.dart';

class HttpService extends HttpServiceCore {
  /* DESC: Khi "url" bạn truyền vào cho mỗi request mà không có base url, ví dụ "/api/user/delete" thì sẽ được tự động gắn base url này */
  String? baseUrl = CONST.API_BASE_URL;

  /* DESC: Thời gian chờ một request phản hồi trong trường hợp mạng yếu hoặc API xử lý chậm */
  int? defaultTimeout = 30; //seconds

  GetStorage box = GetStorage();
  /* DESC: Số lượt thử kết nối lại khi quá thời gian chờ request */
  int? maxTimeRetry = 3;

  // String token = GetStorage().hasData('token') ? GetStorage().read('token') : '';
  /* DESC: Mỗi request tự động sẽ chèn thêm headers này, nó sẽ merge với headers bạn cấu hình trong mỗi request */
  Map<String, String>? defaultHeaders = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer ${GetStorage().hasData('token') ? GetStorage().read('token') : ''}',
  };

  int timet = DateTime.now().microsecondsSinceEpoch;

  String generateC(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /* DESC: Mỗi request tự động sẽ chèn thêm body này, nó sẽ merge với body bạn cấu hình trong mỗi request */
  Map<String, dynamic>? defaultBody = {};

  /* DESC: Sự kiện khi hết thời gian chờ phản hồi của một request */
  void onError(REQUEST_ERROR error) {
    if (error == REQUEST_ERROR.NO_INTERNET) {
      print('No internet');
    } else if (error == REQUEST_ERROR.TIMEOUT) {
      print('Request timeout');
    }
  }

  Future interceptorRequest() async {
    // defaultBody = {'time_request': '$timet', 'code': generateC(generateC(CONST.CODE + timet.toString()))};
  }

  bool isShowLoading = false;

  bool showDebug = true;
  bool enableDebugTool = true;
  String serverDebugTool = 'http://localhost';

  /* DESC: Xử lý dữ liệu trả về  */
  Future<Res> interceptorResponse(Res response) async {
    if (isShowLoading) {
      Get.back();
    }

    // final handleResponse = new HandleReponse(res: response, responseInfo: responseInfo);
    // handleResponse.checkBuilding();

    if (response.body == "Unauthorized" ||
        response.body['error'] == 'Not Authencation') {
      print('unau');
      GetTool().setTimeout(() {
        Get.toNamed('splash');
        GetStorage().write('token', null);
        GetTool().notify.error(
            title: 'Error', message: 'Error authen, please login again!');
      }, 100);
    }
    return response;
  }
}

class HandleReponse {
  final ResponseInfo? responseInfo;
  final Res? res;

  HandleReponse({
    this.res,
    this.responseInfo,
  });
}
