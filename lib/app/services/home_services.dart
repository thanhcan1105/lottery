import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:ykapay/constants.dart';
import 'package:ykapay/models/lottery_model.dart';
import 'package:ykapay/utils/http_service.dart';
import 'package:http/http.dart' as http;

class HomeService extends HttpService {
  GetStorage box = GetStorage();

  // Future getReslut() {
  //   // return res;
  // }
  Future getResult(date, provinces) async {
    final res = await http.get(
      Uri.parse('${CONST.API_BASE_URL}/lottery?date=$date&provinces=$provinces'),
    );
    var bodyResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<LotteryModel> lottery = List.from(
        bodyResponse.map((element) => LotteryModel.fromJson(element)).toList(),
      );
      return lottery;
    } else {
      return null;
    }
  }
}
