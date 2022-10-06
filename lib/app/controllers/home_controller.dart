import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:ykapay/app/services/home_services.dart';
import 'package:ykapay/models/lottery_model.dart';
import 'package:ykapay/utils/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:ykapay/utils/time.dart';

class HomeController extends GetxController with GetTool {
  TextEditingController numberController = TextEditingController();
  TextEditingController tinhController = TextEditingController();

  List<LotteryModel> result = [];
  RxString notification = ''.obs;
  RxString date = ''.obs;
  File? _pickedImage;
  RxString tinh = "".obs;
  RxString image = ''.obs;
  RxBool isLoading = false.obs;
  RxList danhSachTinh = [].obs;

  final lotoRegex = RegExp(r'^[0-9]{6}$');

  @override
  void onInit() async {
    super.onInit();
    date.value = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    chonTinh();
  }

  chonTinh() {
    isLoading.value = true;
    var day = DateFormat('EEEE').format(DateTime.parse(DateFormat('dd-MM-yyyy').parse(date.value).toString()));
    switch (day) {
      case 'Monday':
        danhSachTinh.value = ['TP HỒ CHÍ MINH', 'ĐỒNG THÁP', 'CÀ MAU'];
        break;
      case 'Tuesday':
        danhSachTinh.value = ['BẾN TRE', 'VŨNG TÀU', 'BẠC LIÊU'];
        break;
      case 'Wednesday':
        danhSachTinh.value = ['ĐỒNG NAI', 'CẦN THƠ', 'SÓC TRĂNG'];
        break;
      case 'Thursday':
        danhSachTinh.value = ['TÂY NINH', 'AN GIANG', 'BÌNH THUẬN'];
        break;
      case 'Friday':
        danhSachTinh.value = ['VĨNH LONG', 'BÌNH DƯƠNG', 'TRÀ VINH'];
        break;
      case 'Saturday':
        danhSachTinh.value = ['TP HỒ CHÍ MINH', 'LONG AN', 'BÌNH PHƯỚC', 'HẬU GIANG'];
        break;
      case 'Sunday':
        danhSachTinh.value = ['TIỀN GIANG', 'KIÊN GIANG', 'ĐÀ LẠT'];
        break;
      default:
    }
    isLoading.value = false;
  }

  // excuteSample() async {
  //   var url = Uri.parse('https://xsmn.me/xsag-22-9-2022.html');
  //   var response = await http.get(url);
  //   BeautifulSoup bs = BeautifulSoup(response.body);
  //   var value = numberController.text;
  //   notification.value = 'Bạn chưa trúng thưởng';
  //   giai8(bs, value);
  //   giai7(bs, value);
  //   giai6(bs, value);
  //   giai5(bs, value);
  //   giai4(bs, value);
  //   giai3(bs, value);
  //   giai2(bs, value);
  //   giai1(bs, value);
  //   giaiDB(bs, value);
  //   giaiDBPhu(bs, value);
  //   giaiKK(bs, value);
  // }

  // giai8(bs, value) {
  //   //Giải 8
  //   final giai8 = bs.findAll('span', attrs: {'class': 'v-g8'});
  //   giai8.forEach(
  //     (element) {
  //       if (element.text == value.substring(4)) {
  //         notification.value = 'Bạn đã trúng giải tám - 100.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai7(bs, value) {
  //   //Giải 7
  //   final giai7 = bs.findAll('span', attrs: {'class': 'v-g7'});
  //   giai7.forEach(
  //     (element) {
  //       if (element.text == value.substring(3)) {
  //         notification.value = 'Bạn đã trúng giải bảy - 200.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai6(bs, value) {
  //   //Giải 6
  //   final giai6 = bs.findAll('span', attrs: {'class': 'v-g6-0'});
  //   giai6.forEach(
  //     (element) {
  //       if (element.text == value.substring(2)) {
  //         notification.value = 'Bạn đã trúng giải sáu - 400.000 đ';
  //       }
  //     },
  //   );
  //   final giai6_1 = bs.findAll('span', attrs: {'class': 'v-g6-1'});
  //   giai6_1.forEach(
  //     (element) {
  //       if (element.text == value.substring(2)) {
  //         notification.value = 'Bạn đã trúng giải 6 - 400.000 đ';
  //       }
  //     },
  //   );
  //   final giai6_2 = bs.findAll('span', attrs: {'class': 'v-g6-2'});
  //   giai6_2.forEach(
  //     (element) {
  //       if (element.text == value.substring(2)) {
  //         notification.value = 'Bạn đã trúng giải 6 - 400.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai5(bs, value) {
  //   //Giải 5
  //   final giai5 = bs.findAll('span', attrs: {'class': 'v-g5'});
  //   giai5.forEach(
  //     (element) {
  //       if (element.text == value.substring(2)) {
  //         notification.value = 'Bạn đã trúng giải năm - 1.000.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai4(bs, value) {
  //   //Giải 4
  //   final giai4 = bs.findAll('span', attrs: {'class': 'v-g4-0'});
  //   giai4.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai4_1 = bs.findAll('span', attrs: {'class': 'v-g4-1'});
  //   giai4_1.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai4_2 = bs.findAll('span', attrs: {'class': 'v-g4-2'});
  //   giai4_2.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai4_3 = bs.findAll('span', attrs: {'class': 'v-g4-3'});
  //   giai4_3.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai4_4 = bs.findAll('span', attrs: {'class': 'v-g4-4'});
  //   giai4_4.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai4_5 = bs.findAll('span', attrs: {'class': 'v-g4-5'});
  //   giai4_5.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai4_6 = bs.findAll('span', attrs: {'class': 'v-g4-6'});
  //   giai4_6.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai3(bs, value) {
  //   //Giải 3
  //   final giai3 = bs.findAll('span', attrs: {'class': 'v-g3-0'});
  //   giai3.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải ba - 10.000.000 đ';
  //       }
  //     },
  //   );
  //   final giai3_1 = bs.findAll('span', attrs: {'class': 'v-g3-1'});
  //   giai3_1.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải ba - 10.000.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai2(bs, value) {
  //   //Giải 2
  //   final giai2 = bs.findAll('span', attrs: {'class': 'v-g2'});
  //   giai2.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải nhì - 15.000.000 đ';
  //       }
  //     },
  //   );
  // }

  // giai1(bs, value) {
  //   //Giải 1
  //   final giai1 = bs.findAll('span', attrs: {'class': 'v-g1'});
  //   giai1.forEach(
  //     (element) {
  //       if (element.text == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải nhất - 30.000.000 đ';
  //       }
  //     },
  //   );
  // }

  // giaiDB(bs, value) {
  //   //Giải DB
  //   final giaiDB = bs.findAll('span', attrs: {'class': 'v-gdb'});
  //   giaiDB.forEach(
  //     (element) {
  //       if (element.text == value) {
  //         notification.value = 'Bạn đã trúng giải Đặc Biệt';
  //       }
  //     },
  //   );
  // }

  // giaiDBPhu(bs, value) {
  //   //Giải DB phu
  //   final giaiDBPhu = bs.findAll('span', attrs: {'class': 'v-gdb'});
  //   giaiDBPhu.forEach(
  //     (element) {
  //       if (element.text.substring(1) == value.substring(1)) {
  //         notification.value = 'Bạn đã trúng giải Đặc Biệt phụ - 50.000.000đ';
  //       }
  //     },
  //   );
  // }

  // giaiKK(bs, value) {
  //   //Giải khuyen khich
  //   final giaiKK = bs.findAll('span', attrs: {'class': 'v-gdb'});
  //   giaiKK.forEach(
  //     (element) {
  //         List<String> a = value.split('');
  //         List<String> b = element.text.split('');
  //         if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) != b.elementAt(5)) {
  //           notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
  //         }
  //         if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) != b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
  //           notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
  //         }
  //         if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) != b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
  //           notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
  //         }
  //         if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) != b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
  //           notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
  //         }
  //         if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) != b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
  //           notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
  //         }
  //       }
  //   );
  // }

  getResult() async {
    var dayFormated = DateFormat('d-M-y').format(DateTime.parse(DateFormat('dd-MM-yyyy').parse(date.value).toString()));
    // var tinhh = 'LONG AN';
    var response = await HomeService().getResult(dayFormated, tinh.value);
    if (response != null) {
      result.assignAll(response);
      compare();
    } else {
      Fluttertoast.showToast(msg: 'Dữ liệu chưa có hoặc thông tin nhập vào không chính xác!!');
    }
  }

  compare() {
    var value = numberController.text;
    result.forEach(
      (element) {
        if (element.giai == 0 && element.result == value) {
          notification.value = 'Bạn đã trúng giải Đặc Biệt';
        } else if (element.giai == 0 && element.result!.substring(1) == value.substring(1)) {
          notification.value = 'Bạn đã trúng giải đặc biệt phụ - 50.000.000 đ';
        } else if (element.giai == 0) {
          List<String> a = value.split('');
          List<String> b = element.result!.split('');
          if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) != b.elementAt(5)) {
            notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
          }
          if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) != b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
            notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
          }
          if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) != b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
            notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
          }
          if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) == b.elementAt(1) && a.elementAt(2) != b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
            notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
          }
          if (a.elementAt(0) == b.elementAt(0) && a.elementAt(1) != b.elementAt(1) && a.elementAt(2) == b.elementAt(2) && a.elementAt(3) == b.elementAt(3) && a.elementAt(4) == b.elementAt(4) && a.elementAt(5) == b.elementAt(5)) {
            notification.value = 'Bạn đã trúng giải khuyến khích - 6.000.000 đ';
          }
        } else if (element.giai == 1 && element.result == value.substring(1)) {
          notification.value = 'Bạn đã trúng giải nhất - 30.000.000 đ';
        } else if (element.giai == 2 && element.result == value.substring(1)) {
          notification.value = 'Bạn đã trúng giải nhì - 15.000.000 đ';
        } else if (element.giai == 3 && element.result == value.substring(1)) {
          notification.value = 'Bạn đã trúng giải ba - 10.000.000 đ';
        } else if (element.giai == 4 && element.result == value.substring(1)) {
          notification.value = 'Bạn đã trúng giải tư - 3.000.000 đ';
        } else if (element.giai == 5 && element.result == value.substring(2)) {
          notification.value = 'Bạn đã trúng giải năm - 1.000.000 đ';
        } else if (element.giai == 6 && element.result == value.substring(2)) {
          notification.value = 'Bạn đã trúng giải 6 - 400.000 đ';
        } else if (element.giai == 7 && element.result == value.substring(3)) {
          notification.value = 'Bạn đã trúng giải 7 - 200.000 đ';
        } else if (element.giai == 8 && element.result == value.substring(4)) {
          notification.value = 'Bạn đã trúng giải 8 - 100.000 đ';
        } else {
          notification.value = 'Bạn chưa trúng thưởng';
        }
      },
    );
  }

  dateSelected(value) {
    date.value = value;
  }

  pickedImage(File file) {
    _pickedImage = file;

    InputImage inputImage = InputImage.fromFile(file);
    //code to recognize image
    processImageForConversion(inputImage);
  }

  processImageForConversion(inputImage) async {
    chonTinh();
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      // var outOutText = '';
      // outOutText += block.text + '\n';
      // print(outOutText);

      //** Tinh **//
      List list = [
        'TIỀN GIANG',
        'VĨNH LONG',
        'ĐỒNG THÁP',
        'CÀ MAU',
        'KIÊN GIANG',
        'TP HỒ CHÍ MINH',
        'BẾN TRE',
        'VŨNG TÀU',
        'BẠC LIÊU',
        'ĐỒNG NAI',
        'CẦN THƠ',
        'SÓC TRĂNG',
        'TÂY NINH',
        'AN GIANG',
        'BÌNH THUẬN',
        'BÌNH DƯƠNG',
        'TRÀ VINH',
        'LONG AN',
        'BÌNH PHƯỚC',
        'HẬU GIANG',
        'ĐÀ LẠT',
      ];
      list.forEach((element) {
        if (block.text.toUpperCase().contains(element)) {
          tinh.value = element;
        }
      });

      //**day**//
      if (RegExp(r'^(\d\d-?\d\d-?\d{4})$').hasMatch(block.text.toString())) {
        date.value = block.text;
      }

      //**number**//
      if (RegExp(r'^[0-9]{6}$').hasMatch(block.text.toString())) {
        numberController.text = block.text;
      }
    }
  }

  takedImage(File file) {
    _pickedImage = file;

    InputImage inputImage = InputImage.fromFile(file);
    //code to recognize image
    cameraImageForConversion(inputImage);
  }

  cameraImageForConversion(inputImage) async {
    isLoading.value = true;

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      // outputText.value += block.text + "\n";
      // if (RegExp(r'^[0-9]{6}$').hasMatch(block.text.toString())) {
      //   outputText.value = block.text;
      //   numberController.text = block.text;
      //   print(block.text);
      // }
      if (RegExp(r'^(\d\d-?\d\d-?\d{4})$').hasMatch(block.text.toString())) {
        // outputText.value = block.text;
        // numberController.text = block.text;
        print(block.text);
      }
    }

    isLoading.value = false;
  }
}
