import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_workout_diary_app/global/components/ds_button.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class PageRecordCondition extends StatefulWidget {
  const PageRecordCondition({Key? key}) : super(key: key);

  @override
  State<PageRecordCondition> createState() => _PageRecordConditionState();
}

class _PageRecordConditionState extends State<PageRecordCondition> {
  double score = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
        child: DSButton(
          press: () {
            Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
          },
          text: '저장하기',
          type: ButtonType.normal,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/ic_check.png'),
            SizedBox(
              height: 24,
            ),
            Text('오늘 운동은 어땠나요?', style: DSTextStyles.bold20Black36),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ratingWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingWidget() {
    return RatingBar.builder(
      initialRating: score,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: DSColors.blue03.withAlpha(50),
      itemCount: 5,
      itemSize: (SizeConfig.screenWidth - 150) / 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: DSColors.blue03,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          score = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
