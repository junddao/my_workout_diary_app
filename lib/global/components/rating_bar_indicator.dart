import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';

class CDRatingBar {
  Widget indicator({required double rating, double? starSize}) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: DSColors.blue03,
      ),
      itemCount: 5,
      itemSize: starSize ?? 17.0,
      direction: Axis.horizontal,
    );
  }
}
