import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageBestUser extends StatefulWidget {
  const PageBestUser({Key? key}) : super(key: key);

  @override
  State<PageBestUser> createState() => _PageBestUserState();
}

class _PageBestUserState extends State<PageBestUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: Text('bestUser'),
    );
  }
}
