import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/enum/item_type.dart';
import 'package:my_workout_diary_app/global/provider/workout_provider.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/global/util/data_converter.dart';
import 'package:provider/provider.dart';

class WidgetWorkoutTime extends StatelessWidget {
  const WidgetWorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<WorkoutProvider>().setItemType(ItemType.workout);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(color: Colors.grey, offset: Offset(3, 3), blurRadius: 5),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.play_circle, color: DSColors.tomato),
                  SizedBox(
                    width: 8,
                  ),
                  Text('운동시간', style: DSTextStyles.regular18black),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                DataConvert.intToTimeLeft(context.watch<WorkoutProvider>().workoutTime.toInt()),
                style: DSTextStyles.bold18Tomato,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
