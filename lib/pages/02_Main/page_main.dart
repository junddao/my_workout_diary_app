import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/components/ds_calendar.dart';

class PageMain extends StatefulWidget {
  const PageMain({Key? key}) : super(key: key);

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  @override
  Widget build(BuildContext context) {
    return const PageMainView();
  }
}

class PageMainView extends StatefulWidget {
  const PageMainView({Key? key}) : super(key: key);

  @override
  State<PageMainView> createState() => _PageMainViewState();
}

class _PageMainViewState extends State<PageMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('메인'),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DUCalendar(
            singleSelect: false,
            onDaySelected: (dateTime) {
              debugPrint(dateTime.toString());
            },
          ),
        ],
      ),
    );
  }
}
