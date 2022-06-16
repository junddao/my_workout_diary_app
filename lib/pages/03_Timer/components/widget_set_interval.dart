import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/provider/timer_provider.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:provider/provider.dart';

class WidgetSetInterval extends StatefulWidget {
  const WidgetSetInterval({Key? key}) : super(key: key);

  @override
  State<WidgetSetInterval> createState() => _WidgetSetIntervalState();
}

class _WidgetSetIntervalState extends State<WidgetSetInterval> {
  double _currentSliderValue = 5;
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(builder: (_, data, __) {
      _currentSliderValue = data.interval;
      return Container(
        decoration: BoxDecoration(
          color: DSColors.naver_green,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Column(
              children: [
                const Text('반복횟수', style: DSTextStyles.bold16White),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '${_currentSliderValue.toInt()}', style: DSTextStyles.regular40white),
                      const TextSpan(text: 'X', style: DSTextStyles.regular12White),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Slider(
                  value: _currentSliderValue,
                  max: 10,
                  min: 1,
                  divisions: 9,
                  thumbColor: DSColors.white,
                  inactiveColor: DSColors.white,
                  activeColor: DSColors.white,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    context.read<TimerProvider>().setInterval(value);
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
