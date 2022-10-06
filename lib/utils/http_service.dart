import 'package:get/get.dart';
import 'package:ykapay/utils/http_service_core.dart';

import '../constants.dart';

class HttpService extends HttpServiceCore {
  /* DESC: Khi "url" bạn truyền vào cho mỗi request mà không có base url, ví dụ "/api/user/delete" thì sẽ được tự động gắn base url này */
  String? baseUrl = CONST.API_BASE_URL;

  /* DESC: Thời gian chờ một request phản hồi trong trường hợp mạng yếu hoặc API xử lý chậm */
  int? defaultTimeout = 30; //seconds

  /* DESC: Số lượt thử kết nối lại khi quá thời gian chờ request */
  int? maxTimeRetry = 3;

  /* DESC: Mỗi request tự động sẽ chèn thêm headers này, nó sẽ merge với headers bạn cấu hình trong mỗi request */
  Map<String, String>? defaultHeaders = {'Content-Type': 'application/json'};

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

  /* DESC: Mỗi request sẽ chạy qua hàm này trước khi gửi, bạn có thể cấu hình lấy token gắn vào header ở đây */
  Future interceptorRequest() async {}

  bool isShowLoading = false;

  bool showDebug = true;
  bool enableDebugTool = false;
  //String serverDebugTool = 'http://192.168.1.108';

  /* DESC: Xử lý dữ liệu trả về  */
  Future<Res> interceptorResponse(Res response) async {
    if (isShowLoading) {
      Get.back();
    }

    // final handleResponse = new HandleReponse(res: response, responseInfo: responseInfo);
    // handleResponse.checkBuilding();

    // if (response.body['code'] == 500) {
    //   GetTool().setTimeout(() {
    //     if (Get.isSnackbarOpen) {
    //       Get.back();
    //     }

    //     print(response.body);
    //     GetTool().notify.error(title: 'common_request_error'.tr, message: 'common_server_error'.tr);
    //   }, 10);
    // }

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
