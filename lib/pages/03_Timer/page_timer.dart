import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class PageTimer extends StatefulWidget {
  const PageTimer({Key? key}) : super(key: key);

  @override
  State<PageTimer> createState() => _PageTimerState();
}

class _PageTimerState extends State<PageTimer> {
  @override
  Widget build(BuildContext context) {
    return const PageTimerView();
  }
}

class PageTimerView extends StatefulWidget {
  const PageTimerView({Key? key}) : super(key: key);

  @override
  State<PageTimerView> createState() => _PageTimerViewState();
}

class _PageTimerViewState extends State<PageTimerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('타이머'),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/images/health1.svg',
            width: SizeConfig.screenWidth * 0.5,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('루틴 설정', style: DSTextStyles.bold14Grey06),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: GridView.count(
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 0.8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(6, (index) {
                      //item 의 반목문 항목 형성
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(' Item : $index'),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
