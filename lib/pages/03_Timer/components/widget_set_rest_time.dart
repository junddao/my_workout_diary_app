import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/provider/timer_provider.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:provider/provider.dart';

class WidgetSetRestTime extends StatefulWidget {
  const WidgetSetRestTime({Key? key}) : super(key: key);

  @override
  State<WidgetSetRestTime> createState() => _WidgetSetRestTimeState();
}

class _WidgetSetRestTimeState extends State<WidgetSetRestTime> {
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(builder: (_, data, __) {
      _currentSliderValue = data.restTime;
      return Container(
        decoration: BoxDecoration(
          color: DSColors.facebook_blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Column(
              children: [
                const Text('휴식시간', style: DSTextStyles.bold16White),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '${_currentSliderValue.toInt()}', style: DSTextStyles.regular40white),
                      const TextSpan(text: '초', style: DSTextStyles.regular12White),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Slider(
                  value: _currentSliderValue,
                  max: 60,
                  min: 10,
                  divisions: 10,
                  thumbColor: DSColors.white,
                  inactiveColor: DSColors.white,
                  activeColor: DSColors.white,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    context.read<TimerProvider>().setRestTime(value);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
