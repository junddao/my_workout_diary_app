import 'package:flutter/material.dart';

class PageTimer extends StatefulWidget {
  const PageTimer({Key? key}) : super(key: key);

  @override
  State<PageTimer> createState() => _PageTimerState();
}

class _PageTimerState extends State<PageTimer> {
  @override
  Widget build(BuildContext context) {
    return PageTimerView();
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

  _body() {}
}
