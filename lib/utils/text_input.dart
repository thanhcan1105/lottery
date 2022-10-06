import 'package:flutter/material.dart';
import 'package:ykapay/config/palette.dart';
import 'package:ykapay/utils/validation.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput({
    Key? key,
    this.hintText,
    this.iconData,
    this.textInputType,
    this.controller,
    this.label = '',
    this.rules,
    this.validateCallback,
    //this.isEnable = true,
    this.background,
    this.hintColor,
    this.borderColor,
    this.radius = 10.0,
    this.onTap,
    this.isBorder,
    this.title,
  }) : super(key: key);
  final String? hintText;
  final IconData? iconData;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? label;
  final Map<String, dynamic>? rules;
  final Function? validateCallback;
  final Color? background;
  final Color? hintColor;
  final Color? borderColor;
  final double? radius;
  final Function? onTap;
  final bool? isBorder;
  final String? title;
  //final bool isEnable;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<MyTextInput> {
  var _label;
  bool _initWidget = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.textInputType == TextInputType.visiblePassword;
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius!),
      borderSide: BorderSide(color: widget.borderColor ?? Colors.grey, width: 1, style: BorderStyle.solid),
    );

    final hidePasswordNotifier = ValueNotifier(true);
    return ValueListenableBuilder(
      valueListenable: hidePasswordNotifier,
      builder: (context, bool value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onTap: () {
                widget.onTap;
              },
              controller: widget.controller,
              keyboardType: widget.textInputType,
              obscureText: isPassword ? value : false,
              style: TextStyle(color: Colors.black),
              onChanged: (e) {
                _initWidget = false;
                setState(() {
                  _label = (validate(controller: widget.controller!, rules: widget.rules!));
                  if (_label == '') {
                    widget.validateCallback!(true);
                    _initWidget = true;
                  } else {
                    widget.validateCallback!(false);
                  }
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: widget.background ?? Palette.secondColor.withOpacity(0.2),
                  suffixIcon: isPassword
                      ? IconButton(
                          onPressed: () => hidePasswordNotifier.value = !hidePasswordNotifier.value,
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                            color: Palette.primaryColor,
                          ),
                        )
                      : null,
                  enabledBorder: widget.isBorder == false ? null : outlineInputBorder,
                  hintText: widget.hintText,
                  // label: widget.title!.isEmpty ? null : Text('${widget.title}'),
                  labelText: widget.title,
                  labelStyle: _initWidget == true ? TextStyle(color: Colors.black) : TextStyle(color: Colors.red),
                  focusedBorder:  widget.isBorder == false
                      ? null
                      : outlineInputBorder.copyWith(
                          borderSide: BorderSide(
                              color: _label == null
                                  ? Palette.primaryColor
                                  : _label == ''
                                      ? Palette.secondColor
                                      : Colors.red,
                              width: 2)),
                  hintStyle: TextStyle(color: widget.hintColor ?? Palette.primaryColor),
                  prefixIcon: widget.iconData == null
                      ? null
                      : Icon(widget.iconData,
                          color: _label == null
                              ? Palette.secondColor
                              : _label == ''
                                  ? Palette.secondColor
                                  : Colors.red,
                          size: 18)),
            ),
            SizedBox(
              height: 5,
            ),
            _initWidget == true
                ? Container()
                : Text(
                    '  *${_label}',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
          ],
        );
      },
    );
  }
}

// rules = {
//   'required':'Vui lòng nhập mật khẩu',
//   'minLength':6,
// }
String validate({
  String errorMessage = '',
  Map<String, dynamic>? rules,
  TextEditingController? controller,
}) {
  String errorMessage = '';
  try {
    if (rules!.containsKey('required') && controller!.text == '') {
      rules.forEach(
        (k, v) {
          if (k == 'required') {
            errorMessage = v;
            return;
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('minLength') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (k == 'minLength') {
            if (controller!.text.length < v) {
              errorMessage = 'Tối thiểu $v ký tự';
            } else {
              errorMessage = '';
            }
          }
        },
      );
    }
    if (rules.containsKey('email') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isEmail(controller!.text)) {
            errorMessage = 'Email không hợp lệ';
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('phone') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isPhoneNumber(controller!.text)) {
            errorMessage = 'Số điện thoại không hợp lệ';
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('username') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isUsername(controller!.text)) {
            errorMessage = 'Tài khoản không hợp lệ';
          } else {
            errorMessage = '';
          }
        },
      );
    }
    if (rules.containsKey('emailAndPassword') && errorMessage == '') {
      rules.forEach(
        (k, v) {
          if (!Validator.isEmail(controller!.text)) {
            errorMessage = 'Email hoặc Sđt không hợp lệ';
            if (!Validator.isPhoneNumber(controller.text)) {
              errorMessage = 'Email hoặc Sđt không hợp lệ';
            } else {
              errorMessage = '';
            }
          } else {
            errorMessage = '';
          }
        },
      );
    }

    // else {
    //   errorMessage = '';
    // }
  } catch (e) {}
  return errorMessage;
}
