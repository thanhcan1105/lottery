import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:quiver/iterables.dart';
import 'package:ykapay/constants.dart';

String generateTokenMd5(timestamp) {
  return md5.convert(utf8.encode('youngerx' + timestamp)).toString();
}

// String generateToken() {
//   String number = "";
//   String string = "";
//   String key = "qwertyuiopasdfghjklzxcvbnm";
//   List split = key.split("");
//   for (var i in range(1, 26)) {
//     int random = myRandom(11, 36);
//     number += random.toString();
//     string += string + split[random - 10];
//   }
//   //String enCode = number + StringToHex.toHexString(string).toString();
//   //return enCode.replaceAll(new RegExp(r'0x'), "");
//   return;
// }

myRandom(min, max) {
  var rn = new Random();
  return min + rn.nextInt(max - min);
}

String hexToBinary(String str) {
  var strOk = str.iterable();
  var toHex = "";
  for (var i in range(0, (strOk.length) - 1)) {
    // var hex = strOk.format("%02x", strOk.elementAt(i) as int);
    var hex = int.tryParse(strOk.elementAt(int.parse('$i'))).toString().padLeft(2, '0');
    // var hex = sprintf('%02x', strOk.elementAt(i));
    toHex += hex;
  }
  return "0x" + toHex;
}

extension on String {
  Iterable<String> iterable() sync* {
    for (var i = 0; i < length; i++) {
      yield this[i];
    }
  }
}
