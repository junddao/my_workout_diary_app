import 'dart:math';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

extension StringExtension2 on String? {
  /// 문자열 변환 시 데이터가 없는경우 초기값 제공
  ///
  /// Example:
  /// ```dart
  /// ''.toDefaultString(); // '-'
  /// null.toDefaultString(); // '-'
  /// '123'.toDefaultString(); // '123'
  /// ```
  String toDefaultString(String? defaultString) {
    if (this == null || this!.isEmpty) {
      return defaultString ?? '-';
    } else {
      return this.toString();
    }
  }

  /// 화폐단위로 변환
  ///
  /// Example:
  /// ```dart
  /// '123456789'.toCurrency(); // '123,456,789'
  /// ```
  String toCurrency() {
    if (this == null) {
      return '';
    } else {
      return NumberFormat('###,###,###,###').format(int.parse(this!)).replaceAll(' ', '');
    }
  }

  /// 생년월일 포맷 변환
  ///
  /// Example:
  /// ```dart
  /// '19921001'.toBirthday(); // '1992.10.01'
  /// ```
  String toBirthday() {
    if (this == null) return '';
    if (this!.length != 8) return this!;
    return this!.substring(0, 4) + '.' + this!.substring(4, 6) + '.' + this!.substring(6, 8);
  }

  // 월일
  String toDate() {
    if (this == null) return '';
    if (this!.length != 8) return this!;
    return this!.substring(4, 6) + '.' + this!.substring(6, 8);
  }

  // 분초
  String toTimeWithMinSec() {
    if (this == null) return '';
    int h = this!.toInt() ~/ 3600;
    int m = ((this!.toInt() - h * 3600)) ~/ 60;
    int s = this!.toInt() - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();
    String minuteLeft = m.toString().length < 2 ? "0" + m.toString() : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0" + s.toString() : s.toString();
    String result = "$minuteLeft:$secondsLeft";
    return result;
  }

  /// 가격 포맷
  ///
  /// Example:
  /// ```dart
  /// ''.toPrice(); // '무료'
  /// '325'.toPrice(); // '325'
  /// ```
  String toPrice() {
    if (this == null) {
      return '';
    } else {
      return this!.isEmpty || this == "0" || this == "" ? "무료" : this.toCurrency();
    }
  }

  /// 가격 포맷2
  ///
  /// Example:
  /// ```dart
  /// ''.toPrice(); // '무료'
  /// '325'.toPrice(); // '325원'
  /// ```
  String toPrice2() {
    if (this == null) {
      return '';
    } else {
      return this!.isEmpty || this == "0" || this == "" ? "무료" : this.toCurrency() + "원";
    }
  }

  String toGender() {
    if (this == "MALE") {
      return "남성";
    } else if (this == "FEMALE") {
      return "여성";
    } else {
      return "";
    }
  }

  /// 가격 포맷2
  ///
  /// Example:
  /// ```dart
  /// ''.toPrice(); // '무료'
  /// '325'.toPrice(); // '325원'
  /// ```
  /// 전화번호 형식으로 변환
  ///
  /// Example:
  /// ```dart
  /// '01012344256'.toPhoneNumber(); // '010-1234-4256'
  /// ```
  String toPhoneNumber() {
    if (this == null) return '';

    if (this!.isEmpty) return '';

    if (this!.contains('-')) return this!;

    if (this!.startsWith('0') && !this!.startsWith('00') && this!.length >= 10) {
      if (this!.startsWith('050')) {
        // 050이면
        if (this!.length == 11) {
          // 4-3-4형식
          return this!.substring(0, 4) + '-' + this!.substring(4, 7) + '-' + this!.substring(7, this!.length);
        } else {
          // 4-4-4형식
          return this!.substring(0, 4) + '-' + this!.substring(4, 8) + '-' + this!.substring(8, this!.length);
        }
      } else if (this!.startsWith('02')) {
        // 02번은 2-4-4형식
        return this!.substring(0, 2) + '-' + this!.substring(2, 6) + '-' + this!.substring(6, this!.length);
      } else if (this!.length == 10) {
        // 10자리이면 3-3-4형식
        return this!.substring(0, 3) + '-' + this!.substring(3, 6) + '-' + this!.substring(6, this!.length);
      } else if (this!.length == 11) {
        // 11자리이면 3-4-4형식
        return this!.substring(0, 3) + '-' + this!.substring(3, 7) + '-' + this!.substring(7, this!.length);
      } else {
        return this!;
      }
    } else if (this!.startsWith('15') || this!.startsWith('16') || this!.startsWith('18') && this!.length >= 8) {
      // 상업용 번호, 4-4형식
      return this!.substring(0, 4) + '-' + this!.substring(4, this!.length);
    } else {
      return this!;
    }
  }

  /// Parses string and returns integer value.
  ///
  /// You can set an optional [radix!] to specify the numeric base.
  /// If no [radix!] is set, it will use the decimal system (10).
  ///
  /// Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// '2'.toInt();     // 2
  /// 'invalid'.toInt(); // 0
  /// ```
  int toInt() {
    try {
      if (this == null) return 0;
      return int.parse(this!, radix: 10);
    } catch (error) {
      return 0;
    }
  }

  /// Parses string and return double value.
  ///
  /// Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// '2.1'.toDouble();     // 2.1
  /// 'invalid'.toDouble(); // 0
  /// ```
  double toDouble() {
    try {
      if (this == null) return 0;
      return double.parse(this!);
    } catch (error) {
      return 0;
    }
  }

  /// 접두사 추가
  ///
  /// 추가할 문자 중복 시 제거(deduplication = true로 사용)
  String toPrefixAppend(String appendData, {bool deduplication = false}) {
    try {
      if (this == null || this!.isEmpty) return '';

      if (deduplication) {
        return appendData + this!.replaceAll(appendData, '');
      } else {
        return appendData + this!;
      }
    } catch (error) {
      return '';
    }
  }

  /// 접미사 추가
  ///
  /// 추가할 문자 중복 시 제거(deduplication = true로 사용)
  String toSuffixAppend(String appendData, {bool deduplication = false}) {
    try {
      if (this == null || this!.isEmpty) return '';
      if (deduplication) {
        return this!.replaceAll(appendData, '') + appendData;
      } else {
        return this! + appendData;
      }
    } catch (error) {
      return '';
    }
  }

  String toString2() {
    try {
      if (this == null) return '';
      return this!.toString();
    } catch (error) {
      return '';
    }
  }

  List<Text> toListCharText([TextStyle? style]) {
    try {
      if (this == null) return [];
      String str = this!;
      return List.generate(
          str.length,
          (index) => Text(
                str[index],
                style: style,
              ));
    } catch (error) {
      return [];
    }
  }

  /// Searches the string for the first occurrence of a [pattern] and returns
  /// everything after that occurrence.
  ///
  /// Returns `''` if no occurrences were found.
  ///
  /// Example:
  /// ```dart
  /// 'value=1'.allAfter('=');                 // '1'
  /// 'i like turtles'.allAfter('like')        // ' turtles'
  /// 'i   like cats'.allAfter(RegExp('\\s+')) // 'like cats'
  /// ```
  String allAfter(Pattern pattern) {
    if (this == null) return '';
    var matchIterator = pattern.allMatches(this!).iterator;

    if (matchIterator.moveNext()) {
      var match = matchIterator.current;
      var length = match.end - match.start;
      return this!.substring(match.start + length);
    }
    return '';
  }

  /// Searches the string for the last occurrence of a [pattern] and returns
  /// everything before that occurrence.
  ///
  /// Returns `''` if no occurrences were found.
  ///
  /// Example:
  /// ```dart
  /// 'value=1'.allBefore('=');          // 'value'
  /// 'i like turtles'.allBefore('like') // 'i '
  /// ```
  String allBefore(Pattern pattern) {
    if (this == null) return '';
    var matchIterator = pattern.allMatches(this!).iterator;

    Match? match;
    while (matchIterator.moveNext()) {
      match = matchIterator.current;
    }

    if (match != null) {
      return this!.substring(0, match.start);
    }
    return '';
  }

  /// Searches the string for the first occurrence of [startPattern] and the
  /// last occurrence of [endPattern]. It returns the string between that
  /// occurrences.
  ///
  /// Returns `''` if no occurrences were found.
  ///
  /// Example:
  /// ```dart
  /// 'i like turtles'.allBetween('i ', ' turtles') // 'like'
  /// ```
  String allBetween(Pattern startPattern, Pattern endPattern) {
    return allAfter(startPattern).allBefore(endPattern);
  }

  /// 정규식 확장

  /// 생년월일 확인(1900년생 이후)
  bool get checkBirthDay {
    if (this == null ||
        double.tryParse(this.toString().replaceAll('.', '')) == null ||
        this!.replaceAll('.', '').length != 8) return false;

    String data = this!.replaceAll('.', '');

    DateTime date = DateTime.parse(data);

    String y = date.year.toString().padLeft(4, '0');
    String m = date.month.toString().padLeft(2, '0');
    String d = date.day.toString().padLeft(2, '0');

    if (y.toInt() <= 1900) return false;

    final originalFormatString = "$y$m$d";

    return data == originalFormatString;
  }

  /// null이거나 empty인 경우 true
  bool get isNullEmpty => this == null || this!.isEmpty;

  /// null이 아니고 비어있지 않은 경우 true
  bool get isNotNullEmpty {
    if (this != null) {
      if (this != '') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // ///국가코드를 국가 객체로 가져오기
  // String get toNationality {
  //   if (this == null) return '';

  //   final List<NationalityCode> codes = nationalityCode.map((json) => NationalityCode.fromJson(json)).toList();

  //   var nationality = codes.firstWhereOrNull((e) => e.countryCode == this);
  //   return nationality != null ? nationality.countryName : '';
  // }

  int compareToUnicode(String? other) {
    _StringCompareType thisType = _StringCompareType.nothing;
    if ((this?.length ?? 0) > 0) {
      String ch = this![0];
      if (ch.compareTo('0') >= 0 && ch.compareTo('9') <= 0)
        thisType = _StringCompareType.numeric;
      else if (ch.compareTo('~') <= 0)
        thisType = _StringCompareType.alpha;
      else
        thisType = _StringCompareType.unicode;
    }

    _StringCompareType otherType = _StringCompareType.nothing;
    if ((other?.length ?? 0) > 0) {
      String ch = other![0];
      if (ch.compareTo('0') >= 0 && ch.compareTo('9') <= 0)
        otherType = _StringCompareType.numeric;
      else if (ch.compareTo('~') <= 0)
        otherType = _StringCompareType.alpha;
      else
        otherType = _StringCompareType.unicode;
    }

    switch (thisType) {
      case _StringCompareType.nothing:
        return 1;
      case _StringCompareType.unicode:
        switch (otherType) {
          case _StringCompareType.nothing:
          case _StringCompareType.alpha:
          case _StringCompareType.numeric:
            return -1;
          case _StringCompareType.unicode:
            return this!.compareTo(other!);
        }
      case _StringCompareType.alpha:
        switch (otherType) {
          case _StringCompareType.nothing:
          case _StringCompareType.numeric:
            return -1;
          case _StringCompareType.alpha:
            return this!.compareTo(other!);
          case _StringCompareType.unicode:
            return 1;
        }
      case _StringCompareType.numeric:
        switch (otherType) {
          case _StringCompareType.nothing:
            return -1;
          case _StringCompareType.unicode:
          case _StringCompareType.alpha:
            return 1;
          case _StringCompareType.numeric:
            return this!.compareTo(other!);
        }
    }
  }
}

enum _StringCompareType { unicode, alpha, numeric, nothing }

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

class StringUtils {
  static String random({int length = 10}) {
    var _rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
  }
}
