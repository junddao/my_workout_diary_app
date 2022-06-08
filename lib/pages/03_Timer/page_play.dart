import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/global/components/ds_button.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class PagePlay extends StatefulWidget {
  const PagePlay({Key? key}) : super(key: key);

  @override
  State<PagePlay> createState() => _PagePlayState();
}

class _PagePlayState extends State<PagePlay> {
  @override
  Widget build(BuildContext context) {
    return PagePlayView();
  }
}

class PagePlayView extends StatefulWidget {
  const PagePlayView({Key? key}) : super(key: key);

  @override
  State<PagePlayView> createState() => _PagePlayViewState();
}

class _PagePlayViewState extends State<PagePlayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomSheet(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _bottomSheet() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: SizeConfig.screenWidth,
        height: 130,
        decoration: BoxDecoration(
          color: DSColors.tomato,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Play'),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              workoutCountWidget(),
            ],
          ),
          workoutTimerWidget(),
        ],
      ),
    );
  }

  Widget workoutCountWidget() {
    return Container(
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
              Icon(Icons.play_circle, color: DSColors.facebook_blue),
              SizedBox(
                width: 8,
              ),
              Text('남은횟수', style: DSTextStyles.regular18black),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '1/5',
            style: DSTextStyles.bold18FacebookBlue,
          ),
        ],
      ),
    );
  }

  Widget workoutTimerWidget() {
    return CircularCountDownTimer(
      duration: 10,
      initialDuration: 0,
      controller: CountDownController(),
      width: SizeConfig.screenWidth * 0.7,
      height: SizeConfig.screenHeight * 0.5,
      ringColor: DSColors.gray1,
      ringGradient: null,
      fillColor: DSColors.red01,
      fillGradient: null,
      backgroundColor: DSColors.tomato,
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: DSTextStyles.bold32white,
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
    );
  }

  Widget restTimerWidget() {
    return CircularCountDownTimer(
      duration: 10,
      initialDuration: 0,
      controller: CountDownController(),
      width: SizeConfig.screenWidth * 0.7,
      height: SizeConfig.screenHeight * 0.5,
      ringColor: DSColors.gray1,
      ringGradient: null,
      fillColor: DSColors.red01,
      fillGradient: null,
      backgroundColor: DSColors.tomato,
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: DSTextStyles.bold32white,
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
    );
  }
}
