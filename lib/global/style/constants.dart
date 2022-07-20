import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';

const String test_image_url =
    'https://upload.wikimedia.org/wikipedia/commons/5/5f/%ED%95%9C%EA%B3%A0%EC%9D%80%2C_%EB%AF%B8%EC%86%8C%EA%B0%80_%EC%95%84%EB%A6%84%EB%8B%A4%EC%9B%8C~_%281%29.jpg';

const String defaultUser = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

const String APP_NAME = "마이 헬스 다이어리";

const kPrimaryColor = DSColors.tomato;
const kTextColor = Color(0XFF171717);
const kDefaultCollapseHeight = 100.0;

const kDefaultPadding = 24.0;
const kDefaultVerticalPadding = 10.0;
const kDefaultHorizontalPadding = 24.0;

// default shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black wiht 12% opacity
);

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    defaultSize = orientation == Orientation.landscape ? screenHeight * 0.024 : screenWidth * 0.025;
  }
}

class Validation{
  static var emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
}
