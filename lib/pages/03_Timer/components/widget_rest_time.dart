import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/global/enum/item_type.dart';
import 'package:my_workout_diary_app/global/provider/workout_provider.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/global/util/data_converter.dart';
import 'package:provider/provider.dart';

class WidgetRestTime extends StatelessWidget {
  const WidgetRestTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<WorkoutProvider>().setItemType(ItemType.rest);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
              children: [
                Icon(Icons.pause_circle, color: DSColors.tomato),
                SizedBox(
                  width: 8,
                ),
                Text('휴식시간', style: DSTextStyles.regular18black),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              DataConvert.intToTimeLeft(context.watch<WorkoutProvider>().restTime.toInt()),
              style: DSTextStyles.bold18Tomato,
            ),
          ],
        ),
      ),
    );
  }
}
