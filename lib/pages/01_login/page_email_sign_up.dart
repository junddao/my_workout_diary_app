import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/components/ds_button.dart';
import 'package:my_workout_diary_app/global/components/plain_text_field.component.dart';
import 'package:my_workout_diary_app/global/enum/view_state.dart';
import 'package:my_workout_diary_app/global/provider/auth_provider.dart';
import 'package:my_workout_diary_app/global/provider/user_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/global/util/util.dart';
import 'package:provider/provider.dart';

class PageEmailSignUp extends StatefulWidget {
  const PageEmailSignUp({Key? key}) : super(key: key);

  @override
  State<PageEmailSignUp> createState() => _PageEmailSignUpState();
}

class _PageEmailSignUpState extends State<PageEmailSignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();
  final TextEditingController _tecPasswordCheck = TextEditingController();
  final TextEditingController _tecNickname = TextEditingController();

  @override
  void dispose() {
    _tecEmail.dispose();
    _tecPassword.dispose();
    _tecPasswordCheck.dispose();
    _tecNickname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    var authProvider = context.watch<AuthProvider>();
    return authProvider.state == ViewState.Busy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            "회원가입.",
                            style: DSTextStyles.regularFont(fontSize: 18.0),
                          ),
                          const SizedBox(height: 53),
                          PlainTextField(
                            controller: _tecEmail,
                            hintText: "이메일",
                            keyboardType: TextInputType.emailAddress,
                            // textInputAction: TextInputAction.next,
                            onEditingComplete: () => context.nextEditableTextFocus(),
                            showClear: true,
                            onChanged: (value) {},
                            validator: (val) {
                              return val == null || !RegExp(Validation.emailRegex).hasMatch(val)
                                  ? "이메일이 맞는지 확인해주세요"
                                  : null;
                            },
                          ),
                          const SizedBox(height: 8),
                          PlainTextField(
                            controller: _tecPassword,
                            hintText: "비밀번호",
                            showSecure: true,
                            isSecure: true,
                            onEditingComplete: () => context.nextEditableTextFocus(),
                            validator: (value) {
                              return value == null || value.length < 6 ? "비밀번호를 6 글자 이상으로 해주세요" : null;
                            },
                          ),
                          const SizedBox(height: 8),
                          PlainTextField(
                            controller: _tecPasswordCheck,
                            hintText: "비밀번호 확인",
                            showSecure: true,
                            isSecure: true,
                            onFieldSubmitted: (text) {
                              _signUp();
                            },
                            validator: (value) {
                              logger.i("$value == ${_tecPassword.text} = ${value == _tecPassword.text}");
                              return value == _tecPassword.text ? null : "비밀번호가 서로 다릅니다";
                            },
                          ),
                          const SizedBox(height: 8),
                          PlainTextField(
                            controller: _tecNickname,
                            hintText: "닉네임",
                            showClear: true,
                            // onEditingComplete: () => context.nextEditableTextFocus(),
                            validator: (value) {
                              return value == null || value.isEmpty ? "닉네임을 확인해주세요" : null;
                            },
                          ),
                          const SizedBox(height: 24),
                          DSButton(
                            width: SizeConfig.screenWidth - 40,
                            text: "회원가입",
                            press: () {
                              _signUp();
                            },
                          ),
                          const SizedBox(height: 8),
                          DSButton(
                              width: SizeConfig.screenWidth - 40,
                              text: "로그인으로 돌아가기",
                              // press: () {},
                              press: () {
                                Navigator.of(context).pop();
                              },
                              type: ButtonType.transparent),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  _signUp() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    bool result = await context.read<AuthProvider>().emailSignUp(
          email: _tecEmail.text,
          password: _tecPassword.text,
          name: _tecNickname.text,
        );

    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('회원 가입에 실패했어요. 다시 시도해 주세요.'),
        ),
      );
      return;
    }

    result = await context.read<UserProvider>().getMe();
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('유저 정보를 가져오지 못했습니다. 다시 시도해 주세요.'),
        ),
      );
      return;
    }

    if (result == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그인 실패')));
      return;
    }
  }
}
