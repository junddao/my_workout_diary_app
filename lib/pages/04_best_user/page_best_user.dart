import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';

class PageBestUser extends StatefulWidget {
  const PageBestUser({Key? key}) : super(key: key);

  @override
  State<PageBestUser> createState() => _PageBestUserState();
}

class _PageBestUserState extends State<PageBestUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('이달의 운동왕'),
      centerTitle: false,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('다음달 운동왕은 당신이에요! 😃', style: DSTextStyles.bold18Black),
            SizedBox(height: 18),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildRankListItem();
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankListItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          border: Border.all(color: DSColors.warm_grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: ClipOval(
                child: Image.asset('assets/images/default_profile.png', fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '김운동', style: DSTextStyles.bold18Black),
                        TextSpan(text: '님', style: DSTextStyles.bold14WarmGrey),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '이번달은 ', style: DSTextStyles.bold12WarmGrey),
                        TextSpan(text: '23일', style: DSTextStyles.bold14Black),
                        TextSpan(text: ' 운동했어요.', style: DSTextStyles.bold12WarmGrey),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '총 운동시간은 \n', style: DSTextStyles.regular12WarmGrey),
                        TextSpan(text: '30시간 20분 10초', style: DSTextStyles.bold14Black),
                        TextSpan(text: ' 입니다.', style: DSTextStyles.regular12WarmGrey),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
