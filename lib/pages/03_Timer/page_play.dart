import 'dart:async';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_workout_diary_app/global/components/ds_button.dart';
import 'package:my_workout_diary_app/global/enum/countdown_type.dart';
import 'package:my_workout_diary_app/global/enum/item_type.dart';
import 'package:my_workout_diary_app/global/enum/working_type.dart';
import 'package:my_workout_diary_app/global/provider/workout_provider.dart';
import 'package:my_workout_diary_app/global/service/audio_service.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:provider/provider.dart';

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
  int readyTime = 5;
  int workoutTime = 20;
  int restTime = 30;

  int currentInterval = 1;

  bool isStarted = false;
  bool isWorkout = false;
  late WorkoutProvider workoutProvider;
  late Timer _timer;
  int _time = 0;
  bool _isRunning = false;

  // final player = AudioPlayer(
  //   handleInterruptions: false,
  //   androidApplyAudioAttributes: false,
  //   handleAudioSessionActivation: false,
  // );

  CountDownController workoutCountdownController = CountDownController();
  CountDownController restCountdownController = CountDownController();

  @override
  void initState() {
    Future.microtask(() {
      workoutProvider.setCountdownType(CountdownType.stopped);
      workoutProvider.setWorkingType(WorkingType.ready);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    workoutProvider = context.watch<WorkoutProvider>();

    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomSheet(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _bottomSheet() {
    return InkWell(
      onTap: () {
        if (workoutProvider.countdownType == CountdownType.stopped) {
          workoutProvider.setCountdownType(CountdownType.started);
          workoutProvider.setWorkingType(WorkingType.ready);
          workoutCountdownController.start();
        } else if (workoutProvider.countdownType == CountdownType.started) {
          workoutProvider.setCountdownType(CountdownType.paused);
          workoutCountdownController.pause();
          _pause();
        } else if (workoutProvider.countdownType == CountdownType.paused) {
          workoutProvider.setCountdownType(CountdownType.started);
          workoutCountdownController.resume();
          _start(getDuration());
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: 130,
        decoration: BoxDecoration(
          color: (() {
            if (workoutProvider.workingType == WorkingType.rest) {
              return DSColors.facebook_blue;
            }
            if (workoutProvider.workingType == WorkingType.workout) {
              return DSColors.tomato;
            }
            return DSColors.naver_green;
          }()),
        ),
        child: Center(
          child: Icon(
            (() {
              if (workoutProvider.countdownType == CountdownType.started) {
                return Icons.pause;
              } else if (workoutProvider.countdownType == CountdownType.paused) {
                return Icons.play_arrow;
              } else if (workoutProvider.countdownType == CountdownType.stopped) {
                return Icons.play_arrow;
              }
            }()),
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
          SizedBox(height: 18),

          (() {
            if (workoutProvider.workingType == WorkingType.rest) {
              return Text('휴식중', style: DSTextStyles.bold18FacebookBlue);
            }
            if (workoutProvider.workingType == WorkingType.workout) {
              return Text('운동중', style: DSTextStyles.bold18Tomato);
            }
            return Text('준비!', style: DSTextStyles.bold18NaverGreen);
          }()),

          workoutTimerWidget(),

          // Visibility(
          //   visible: data.workingType == WorkingType.rest,
          //   child: restTimerWidget(data),
          // ),
          // Visibility(
          //   visible: data.workingType == WorkingType.workout,
          //   child: workoutTimerWidget(data),
          // ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_circle, color: DSColors.facebook_blue),
                SizedBox(
                  width: 8,
                ),
                Text('루틴', style: DSTextStyles.regular18black),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: DSTextStyles.bold18FacebookBlue,
              children: [
                TextSpan(
                  text: '$currentInterval',
                  // style: DSTextStyles.bold18FacebookBlue,
                ),
                TextSpan(
                  text: ' / ',
                  // style: DSTextStyles.bold18FacebookBlue,
                ),
                TextSpan(
                  text: '${workoutProvider.interval.toInt()}',
                  // style: DSTextStyles.bold18FacebookBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget workoutTimerWidget() {
    return CircularCountDownTimer(
      // duration: data.workoutTime.toInt(),
      duration: 5,

      initialDuration: 0,
      controller: workoutCountdownController,
      width: SizeConfig.screenWidth * 0.7,
      height: SizeConfig.screenHeight * 0.5,
      ringColor: DSColors.gray1,
      ringGradient: null,
      fillColor: (() {
        if (workoutProvider.workingType == WorkingType.rest) {
          return DSColors.blue1;
        }
        if (workoutProvider.workingType == WorkingType.workout) {
          return DSColors.red01;
        }
        return DSColors.tomato_10;
      }()),

      fillGradient: null,
      backgroundColor: (() {
        if (workoutProvider.workingType == WorkingType.rest) {
          return DSColors.facebook_blue;
        }
        if (workoutProvider.workingType == WorkingType.workout) {
          return DSColors.tomato;
        }
        return DSColors.naver_green;
      }()),

      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: DSTextStyles.bold32white,
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,

      onStart: () {
        debugPrint('Countdown Started');
        int duration = getDuration();

        _start(duration);

        // Future.delayed(
        //   Duration(seconds: duration - 4),
        //   () async {
        //     // var duration = await player.setAsset('assets/audios/countdown.wav');
        //     await AudioService().start();
        //   },
        // );
      },
      onComplete: () {
        _reset();
        // Future.microtask(() async => await AudioService().stop());

        if (workoutProvider.workingType == WorkingType.rest) {
          workoutProvider.setWorkingType(WorkingType.workout);
        } else if (workoutProvider.workingType == WorkingType.workout) {
          currentInterval++;
          workoutProvider.setWorkingType(WorkingType.rest);
        } else if (workoutProvider.workingType == WorkingType.ready) {
          workoutProvider.setWorkingType(WorkingType.workout);
        }

        if (currentInterval <= workoutProvider.interval) {
          int duration = 5;
          if (workoutProvider.workingType == WorkingType.rest) {
            duration = workoutProvider.restTime.toInt();
          }
          if (workoutProvider.workingType == WorkingType.workout) {
            duration = workoutProvider.workoutTime.toInt();
          }

          workoutCountdownController.restart(duration: duration);
        } else {
          currentInterval--;
          print(workoutCountdownController);
        }
      },
    );
  }

  void _start(int beepTime) {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) async {
      _time++;
      if (beepTime - 4 == _time / 100) {
        await AudioService().start();
      }
    });
  }

  // 타이머 취소
  void _pause() {
    _timer.cancel();
  }

  void _reset() async {
    _isRunning = false;
    _timer.cancel();
    _time = 0;
    await AudioService().stop();
  }

  int getDuration() {
    int duration = 5;
    if (workoutProvider.workingType == WorkingType.rest) {
      duration = workoutProvider.restTime.toInt();
    }
    if (workoutProvider.workingType == WorkingType.workout) {
      duration = workoutProvider.workoutTime.toInt();
    }

    return duration;
  }
}
