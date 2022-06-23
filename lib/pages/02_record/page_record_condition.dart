import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_workout_diary_app/global/components/ds_button.dart';
import 'package:my_workout_diary_app/global/enum/condition_type.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_create_record.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:provider/provider.dart';

class PageRecordCondition extends StatefulWidget {
  const PageRecordCondition({Key? key}) : super(key: key);

  @override
  State<PageRecordCondition> createState() => _PageRecordConditionState();
}

class _PageRecordConditionState extends State<PageRecordCondition> {
  ValueNotifier<double> score = ValueNotifier(3);
  ConditionType condition = ConditionType.GD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
        child: DSButton(
          press: () {
            switch (score.value.toInt()) {
              case 1:
                condition = ConditionType.BD;
                break;
              case 2:
                condition = ConditionType.NB;
                break;
              case 3:
                condition = ConditionType.GD;
                break;
              case 4:
                condition = ConditionType.VG;
                break;
              default:
                condition = ConditionType.GT;
                break;
            }
            ModelRequestCreateRecord modelRequestCreateRecord = ModelRequestCreateRecord(
              workoutTime: context.read<RecordProvider>().time ~/ 10,
              condition: condition,
              endTime: context.read<RecordProvider>().startTime,
              startTime: context.read<RecordProvider>().endTime,
            );
            context.read<RecordProvider>().createRecord(modelRequestCreateRecord);
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
            ValueListenableBuilder<double>(
                valueListenable: score,
                builder: (context, value, child) {
                  switch (value.toInt() - 1) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                        size: (SizeConfig.screenWidth - 150) / 3,
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                        size: (SizeConfig.screenWidth - 150) / 3,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                        size: (SizeConfig.screenWidth - 150) / 3,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                        size: (SizeConfig.screenWidth - 150) / 3,
                      );
                    default:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                        size: (SizeConfig.screenWidth - 150) / 3,
                      );
                  }
                }),
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
      initialRating: score.value,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      unratedColor: DSColors.blue03.withAlpha(50),
      itemCount: 5,
      itemSize: (SizeConfig.screenWidth - 150) / 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
      itemBuilder: (context, _) {
        switch (_) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          default:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
        }
      },
      onRatingUpdate: (rating) {
        print('${score.value} $rating');
        // setState(() {
        score.value = rating;
        // });
      },
      updateOnDrag: true,
    );
  }
}
