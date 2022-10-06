class Validator {
  static isPhoneNumber(String phoneNumber) {
    String pattern = r"^(0|84|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))\d{7}$";

    return new RegExp(pattern).hasMatch(phoneNumber);
  }

  static isPhoneNumberSimple(String phoneNumber) {
    String pattern = r"^(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})\b$";

    return new RegExp(pattern).hasMatch(phoneNumber);
  }

  static isEmail(String email) {
    String pattern = r"^(.+)@(.+).(.+)$";

    return new RegExp(pattern).hasMatch(email);
  }

  static isUsername(String username) {
    String pattern = r"^(?=[a-zA-Z0-9._]{6,20}$)(?!.*[_.]{2})[^_.].*[^_.]$";
    return new RegExp(pattern).hasMatch(username);
  }

  static isNumber(String number) {
    String pattern = r"^-?\d+$";

    return new RegExp(pattern).hasMatch(number);
  }

  static isImage(String imagePath) {
    String pattern = r"^(.+)\.(jpeg|jpg|png)$";

    return new RegExp(pattern).hasMatch(imagePath);
  }

  static isMalFile(String filePath) {
    String pattern = r"^(.+)\.mal$";

    return new RegExp(pattern).hasMatch(filePath);
  }

  static isMalDbBackupFile(String filePath) {
    String pattern = r"^([0-9]+)\.mal$";

    return new RegExp(pattern).hasMatch(filePath);
  }

  static isBackupImgsFolder(String folderName) {
    String pattern = r"^\d{4}-\d{2}$";

    return new RegExp(pattern).hasMatch(folderName);
  }
}
