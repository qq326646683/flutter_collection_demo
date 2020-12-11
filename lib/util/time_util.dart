class TimeUtil {

  // 今天：14:00 PM
  // 过去：04-23 08:00 AM
  static String hourMinuteAndAmUI(DateTime date) {
    String amStr = 'AM';
    if (date.hour >= 12) {
      amStr = 'PM';
    }
    if (_isTodayBefore(date)) {
      return '${monthDayUI(date)} ${hourMinuteUI(date)} $amStr';
    } else {
      return '${hourMinuteUI(date)} $amStr';
    }
  }

  static String hourMinuteUI(DateTime date) {
    int hour = date.hour;
    int minute = date.minute;
    String hourStr = hour.toString();
    String minuteStr = minute.toString();
    if (hour < 10) {
      hourStr = '0$hour';
    }
    if (minute < 10) {
      minuteStr = '0$minute';
    }
    return '$hourStr:$minuteStr';
  }

  static String monthDayUI(DateTime date) {
    int month = date.month;
    int day = date.day;
    String monthStr = month.toString();
    String dayStr = day.toString();
    if (month < 10) {
      monthStr = '0$month';
    }
    if (day < 10) {
      dayStr = '0$day';
    }
    return '$monthStr-$dayStr';
  }

  static _isTodayBefore(DateTime date) {
    bool isTodayBefore = false;
    // 今天零点
    DateTime now = DateTime.now();
    DateTime todayZore = new DateTime(now.year, now.month, now.day);
    if (date.difference(todayZore).inSeconds < 0) {
      isTodayBefore = true;
    }
    return isTodayBefore;
  }

  static String secondToMinuteAndSecondUI(int seconds) {
    String res = '';
    if (seconds < 60) {
      if (seconds < 10) {
        res = '00:0$seconds';
      } else {
        res = '00:$seconds';
      }
    } else {
      int minute = (seconds / 60).floor();
      int second = seconds % 60;
      String minuteStr = minute.toString();
      String secondStr = second.toString();
      if (minute < 10) {
        minuteStr = '0$minute';
      }
      if (second < 10) {
        secondStr = '0$second';
      }
      res = '$minuteStr:$secondStr';
    }
    return res;
  }

  static Future sleep(int mill) {
    return Future.delayed(Duration(milliseconds: mill));
  }

  static String getDayMonthYearByTimestamp(int timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${time.day}/${time.month}/${time.year}';
  }

  ///计算两个时间戳的相差年份
  static int diffYear(int starTimestamp, int endTimestamp) {
    return ((endTimestamp - starTimestamp) / 1000 / 60 / 60 /24).ceil();
  }
}