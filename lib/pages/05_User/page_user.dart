import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_workout_diary_app/global/components/ds_button.dart';
import 'package:my_workout_diary_app/global/components/ds_input_field.dart';
import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/login_provider.dart';
import 'package:my_workout_diary_app/global/provider/user_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:provider/provider.dart';

class PageUser extends StatefulWidget {
  const PageUser({Key? key}) : super(key: key);

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  @override
  Widget build(BuildContext context) {
    return PageUserView();
  }
}

class PageUserView extends StatefulWidget {
  const PageUserView({Key? key}) : super(key: key);

  @override
  State<PageUserView> createState() => _PageUserViewState();
}

class _PageUserViewState extends State<PageUserView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tecName = TextEditingController();

  @override
  void dispose() {
    _tecName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('마이'),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          onPressed: () {
            // onSave();
          },
          child: Text(
            '등록하기',
            style: DSTextStyles.bold14Tomato,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    final FocusScopeNode node = FocusScope.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: CachedNetworkImage(
                                imageUrl: context.watch<UserProvider>().me.profileImage ?? defaultUser,
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              )),
                          Positioned(
                            top: 60,
                            left: 60,
                            child: Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: DSColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(width: 1, color: DSColors.grey_06)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.camera_alt,
                                    color: DSColors.grey_06,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: '안녕하세요\n', style: DSTextStyles.bold18WarmGrey),
                            TextSpan(text: '${context.watch<UserProvider>().me.name}', style: DSTextStyles.bold18Black),
                            TextSpan(text: '님!', style: DSTextStyles.bold18WarmGrey),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(context.watch<UserProvider>().me.email!),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('이름 수정하기', style: DSTextStyles.bold18Black),
              DSInputField(
                controller: _tecName,
                hintText: "변경하실 성명을 입력해주세요",
                warningMessage: "성명을 입력해주세요",
                onEditingComplete: () => node.nextFocus(),
                validator: (value) {
                  if (value!.length > 10) {
                    return "10자 내로 입력해주세요.";
                  }
                },
              ),
              const SizedBox(height: 40),
              DSButton(
                  text: '로그아웃',
                  press: () {
                    _logout();
                  },
                  type: ButtonType.warning,
                  width: SizeConfig.screenWidth),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _logout() async {
    bool result = await context.read<LoginProvider>().signOut();
    if (result) {
      Navigator.of(context).pushNamed('PageLogin');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그아웃을 실패했습니다. 다시 시도해주세요.'),
        ),
      );
    }
  }

  // _body() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         Text(context.watch<UserProvider>().me.email ?? ''),
  //       ],
  //     ),
  //   );
  // }
}
