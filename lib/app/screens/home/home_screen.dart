import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ykapay/app/controllers/home_controller.dart';
import 'package:ykapay/utils/time.dart';

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({DateTime? currentTime, DateTime? minTime, DateTime? maxTime, LocaleType? locale})
      : super(
          locale: locale,
          minTime: minTime,
          maxTime: maxTime,
          currentTime: currentTime,
        );

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}

class HomeScreen extends GetView<HomeController> {
  void pickImage(source, Function(File) imgFile) async {
    ImagePicker imgPicker = ImagePicker();

    XFile? file = await imgPicker.pickImage(source: source);
    if (file == null) return;
    imgFile(File(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          leading: Center(),
          title: Text(
            'Dò số nhanh',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: Get.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Vé số của bạn',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Số:   '),
                              Container(
                                width: Get.width * 0.25,
                                height: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  controller: controller.numberController,
                                  onChanged: (value) {
                                    // controller.compare();
                                  },
                                ),
                              ),
                              Spacer(),
                              Text('Ngày:  '),
                              InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime(2015, 1, 1),
                                    maxTime: DateTime.now(),
                                    onChanged: (date) {},
                                    onConfirm: (date) {
                                      controller.tinh.value = '';
                                      controller.dateSelected($Datetime.formatFromString(date.toString(), 'dd-MM-yyyy'));
                                      controller.chonTinh();
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi,
                                  );
                                },
                                child: Container(
                                  width: Get.width * 0.35,
                                  height: 30,
                                  padding: EdgeInsets.only(
                                    left: 5,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Obx(
                                    () => Text(
                                      controller.date.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Đài: '),
                              Obx(
                                () => controller.isLoading.value
                                    ? CircularProgressIndicator()
                                    : Container(
                                        width: Get.width * 0.5,
                                        height: 30,
                                        child: DropdownButtonFormField2(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          isExpanded: true,
                                          hint: Text(
                                            controller.tinh.isNotEmpty ? controller.tinh.value : 'Chọn tỉnh',
                                            style: TextStyle(fontSize: 14, color: Colors.black),
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          iconSize: 30,
                                          buttonHeight: 60,
                                          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          items: controller.danhSachTinh
                                              .map((item) => DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Vui lòng chọn tỉnh.';
                                            }
                                          },
                                          onChanged: (value) {},
                                        ),
                                      ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // FocusScope.of(context).requestFocus(new FocusNode());
                                  controller.getResult();
                                  showAboutDialog(context: context);
                                },
                                child: Container(
                                  width: 60,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'Dò',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Nếu thông tin không chính xác, vui lòng điều chỉnh thông tin và nhấn nút dò',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          pickImage(ImageSource.gallery, controller.pickedImage);
                        },
                        child: Container(
                          width: Get.width * 0.44,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Chọn ảnh có sẵn',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          // Get.to(CameraScreen());
                          pickImage(ImageSource.camera, controller.takedImage);
                        },
                        child: Container(
                          width: Get.width * 0.44,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Chụp ảnh mới',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Text(controller.notification.value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
