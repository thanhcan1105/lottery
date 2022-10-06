import 'package:intl/intl.dart';

class $Time {
  static timestampToDate(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date;
  }
}

class $Datetime {
  static int dateTimeToTimestamp(DateTime datetime) => (datetime.millisecondsSinceEpoch / 1000).floor();

  static DateTime timestampToDateTime(int timestamp) {
    int timestampCuted = int.parse(timestamp.toString().substring(0, 10));

    return DateTime.fromMillisecondsSinceEpoch(timestampCuted * 1000);
  }

  static String format(DateTime datetime, String formatStyle) {
    return DateFormat(formatStyle).format(datetime);
  }

  static String formatFromTimestamp(int timestamp, String formatStyle) {
    DateTime datetime = $Datetime.timestampToDateTime(timestamp);
    return DateFormat(formatStyle).format(datetime);
  }

  static String formatFromString(String datetime, String formatStyle) {
    return DateFormat(formatStyle).format(DateTime.parse(datetime));
  }

  static DateTime stringToDateTime(String datetimeString) {
    return DateTime.parse(datetimeString);
  }

  static String timeAgo(DateTime d) {
    // var dateLocal = diff
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(d.toString(), true);
    var dateLocal = dateTime.toLocal();
    Duration diff = DateTime.now().difference(dateLocal);
    // print(diff);
    // if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "năm" : "năm"} trước";
    // if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "tháng" : "tháng"} trước";
    // if (diff.inDays > 7) return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "tuần" : "tuần"} trước";
    if (diff.inDays > 6) return DateFormat('dd/MM/yyyy').format(DateTime.parse(d.toString()));
    if (diff.inDays > 0) return "${diff.inDays} ngày trước";
    if (diff.inHours > 0) return "${diff.inHours} ${diff.inHours == 1 ? "tiếng" : "tiếng"} trước";
    if (diff.inMinutes > 0) return "${diff.inMinutes} ${diff.inMinutes == 1 ? "phút" : "phút"} trước";
    return "vừa xong";
  }

  static getCurrentTimestamp() => (DateTime.now().millisecondsSinceEpoch / 1000).floor();

  static DateTime replace(
    DateTime datetime, {
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? datetime.year,
      month ?? datetime.month,
      day ?? datetime.day,
      hour ?? datetime.hour,
      minute ?? datetime.minute,
      second ?? datetime.second,
      millisecond ?? datetime.millisecond,
      microsecond ?? datetime.microsecond,
    );
  }

  static String getLabelFromDateTime(
    DateTime datetime, {
    bool isOnlyDayName = false,
    String middle = " -",
  }) {
    DateTime now = $Datetime.replace(DateTime.now(), hour: 0, minute: 0, second: 0);
    DateTime dateCompare = $Datetime.replace(datetime, hour: 0, minute: 0, second: 0);

    int difference = now.difference(dateCompare).inHours;
    String label = "";

    if (difference == -23) {
      label = "Ngày mai";
    } else if (difference == 0) {
      label = "Hôm nay";
    } else if (difference == 24) {
      label = "Hôm qua";
    } else {
      Map daysName = {
        1: "Thứ hai",
        2: "Thứ ba",
        3: "Thứ tư",
        4: "Thứ năm",
        5: "Thứ sáu",
        6: "Thứ bảy",
        7: "Chủ nhật",
      };

      label = daysName[datetime.weekday];
    }

    String result = label;

    if (!isOnlyDayName) {
      result += "$middle ${$Datetime.format(datetime, 'dd/MM/yyyy')}";
    }

    return result;
  }
}
