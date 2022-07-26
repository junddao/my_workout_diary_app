import 'package:intl/intl.dart';

/// 기준 : 2021년 4월 17일 오후 3시 55분 20초
/// value.toFormatString('y') // '2021년'
/// value.toFormatString('yMMMM') // '2021년 4월'
/// value.toFormatString('yMMMMd') // '2021년 4월 17일'
/// value.toFormatString('yMMMMEEEEd') // '2021년 4월 17일 토요일'
/// value.toFormatString('yMMMMEEEEd a hh:mm') // '2021년 4월 17일 토요일 오후 3:55
/// value.toFormatString('yMMMMEEEd a hh:mm') // '2021년 4월 17일 토 오후 3:55
/// value.toFormatString('yMMMMEEEEd HH:mm') // '2021년 4월 17일 토요일 15:55'
///
/// value.toFormatString('yyyy-MM-DD') // '2021-04-17'
/// value.toFormatString('yyyy-MM') // '2021-04'
/// value.toFormatString('yyyy') // '2021'
/// value.toFormatString('HH:mm:ss') // '15:55:20'
/// value.toFormatString('HH:mm') // '15:55'
/// value.toFormatString('HH') // '15'
extension DSDateTime on DateTime {
  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString(); // 2021년 4월 26일 월요일 오전 11:39:12
  /// ```
  String toFullDateTimeString() {
    return DateFormat('yMMMMEEEEd').add_jms().format(this.toLocal());
  }

  /// 상품용 날짜 포맷
  String toProductDateForm() {
    return DateFormat('yyyy.MM.dd (E)').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString2(); // 2021.04.26 11:39
  /// ```
  String toFullDateTimeString2() {
    return DateFormat('yyyy.MM.dd HH:mm').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString3(); // 2021.04.26 월요일 11:39
  /// ```
  String toFullDateTimeString3() {
    return DateFormat('yyyy.MM.dd EEEE HH:mm').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString4(); // 2021.04.26 AM 11:39
  /// ```
  String toFullDateTimeString4() {
    return DateFormat('yyyy.MM.dd  a hh:mm', 'en_US').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString5(); // 2021.04.26(월) 11:39
  /// ```
  String toFullDateTimeString5() {
    return DateFormat('yyyy.MM.dd(EEE) HH:mm').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString6(); // 2021.04.26 오전 11:39
  /// ```
  String toFullDateTimeString6() {
    return DateFormat('yyyy.MM.dd  a hh:mm').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateTimeString6(); // 2021.04.26 오전 11:39
  /// ```
  String toFullDateTimeString7() {
    return DateFormat('yyyy.MM.dd  a hh:mm:ss.SSS').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateString1(); // 2021년 4월 26일 월요일
  /// ```
  String toFullDateString1() {
    return DateFormat('yMMMMEEEEd').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateString2(); // 2021년 4월 26일
  /// ```
  String toFullDateString2() {
    return DateFormat('yMMMMd').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toFullDateString3(); // 2021.04.26
  /// ```
  String toFullDateString3() {
    return DateFormat('yyyy.MM.dd').format(this.toLocal());
  }

  String toFullDateCustom(String str) {
    return DateFormat('yyyy${str}MM${str}dd').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateString1(); // 4월 26일
  /// ```
  String toDateString1() {
    return DateFormat('MMMMd').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateString2(); // 04.26
  /// ```
  String toDateString2() {
    return DateFormat('MM.dd').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateString3(); // 26
  /// ```
  String toDateString3() {
    return DateFormat('dd').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateYearString(); // 4월
  /// ```
  String toDateYearString() {
    return DateFormat('MMMM').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateYearString2(); // 04
  /// ```
  String toDateYearString2() {
    return DateFormat('MM').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateMonthString(); // 26일
  /// ```
  String toDateMonthString() {
    return DateFormat('d').format(this.toLocal());
  }

  /// 날짜 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toDateMonthString2(); // 26
  /// ```
  String toDateMonthString2() {
    return DateFormat('dd').format(this.toLocal());
  }

  /// 시간 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toTimestampString1(); // 오전 11:39
  /// ```
  String toTimestampString1() {
    return DateFormat('jm').format(this.toLocal());
  }

  String toFullDateString3NonLocal() {
    return DateFormat('yyyy.MM.dd').format(this);
  }

  /// 시간 가변 포맷
  ///
  /// Example:
  /// ```dart
  /// 현재 시간과 비교해서 세 가지 포맷 중 하나로 출력합니다.
  ///
  /// value.toFormatString('yMMMM') // '2021년 4월'
  /// datetimeA.toDateString1(); // 4월 26일
  /// datetimeA.toTimestampString1(); // 오전 11:39
  /// ```
  String toVariationString1() {
    final now = DateTime.now().toLocal();
    if (this.isSameDate(now)) {
      return DateFormat('jm').format(this.toLocal());
    } else if (this.year == now.year) {
      return toDateString1();
    } else {
      return DateFormat('yMMMM').format(this.toLocal());
    }
  }

  /// 시간 포맷
  ///
  /// Example:
  /// ```dart
  /// datetimeA.toTimestampString2(); // 11:39
  /// ```
  String toTimestampString2() {
    return DateFormat('hh:mm').format(this.toLocal());
  }

  String toTimeStampWithMinSec() {
    return DateFormat('mm:ss').format(this.toLocal());
  }

  /// 날짜 비교
  ///
  /// Example:
  /// ```dart
  /// datetimeA.isSameDate(datetimeB); // true
  /// ```
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }

  /// Returns the [bool] wheather the given date are inside iterval or not.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2000, 1, 2).isBetween(DateTime(2000, 1, 1), DateTime(2000, 1, 31)); // true
  /// DateTime(2000, 1, 1).isBetween(DateTime(2000, 1, 1), DateTime(2000, 1, 1)); // true
  /// ```
  bool isBetween(DateTime from, DateTime to) {
    return (isAfter(from) && isBefore(to)) || this == from || this == to;
  }

  bool isBetweenDay(DateTime from, DateTime to) {
    var a = DateTime.utc(from.year, from.month, from.day, 0, 0, 0);
    var b = DateTime.utc(to.year, to.month, to.day, 11, 59, 59);

    var after = isAfter(a);
    var before = isBefore(b);
    return (after && before);
  }

  static int _serverNowMilliseconds = 0;
  static int _serverInitUptime = 0;
}
