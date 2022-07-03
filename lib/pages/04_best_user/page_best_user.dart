import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/global/enum/view_state.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_rankers.dart';
import 'package:my_workout_diary_app/global/model/record/model_response_get_rankers.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:provider/provider.dart';

class PageBestUser extends StatefulWidget {
  const PageBestUser({Key? key}) : super(key: key);

  @override
  State<PageBestUser> createState() => _PageBestUserState();
}

class _PageBestUserState extends State<PageBestUser> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      int year = DateTime.now().year;
      int month = DateTime.now().month;
      final startDate = DateTime(year, month, 1);
      ModelRequestGetRankers input = ModelRequestGetRankers(startDate: startDate, endDate: DateTime.now());
      context.read<RecordProvider>().getTopRankers(input);
    });
  }

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
    return Consumer<RecordProvider>(builder: (_, provider, __) {
      if (provider.state == ViewState.Busy) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      final rankers = provider.rankers;
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('다음달 운동왕은 당신이에요! 😃', style: DSTextStyles.bold18Black),
              SizedBox(height: 18),
              provider.rankers.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.3),
                        Center(
                          child: Text('이번달 운동을 시작한 사람이 없어요. 😭'),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildRankListItem(rankers, index);
                      },
                      itemCount: provider.rankers.length,
                    ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRankListItem(List<ModelRankers> rankers, int index) {
    int days = rankers[index].workoutDates.length;
    int hours = rankers[index].totalWorkoutTime ~/ (60 * 60);
    int minutes = (rankers[index].totalWorkoutTime - hours * 3600) ~/ 60;
    int seconds = rankers[index].totalWorkoutTime - (hours * 3600) - (minutes * 60);
    String userImage = rankers[index].profileImage == null || rankers[index].profileImage!.isEmpty
        ? defaultUser
        : rankers[index].profileImage!;
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
                  child: CachedNetworkImage(
                imageUrl: userImage,
                fit: BoxFit.cover,
              )),
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
                        TextSpan(text: rankers[index].userName, style: DSTextStyles.bold18Black),
                        TextSpan(text: '님', style: DSTextStyles.bold14WarmGrey),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '이번달은 ', style: DSTextStyles.regular12WarmGrey),
                        TextSpan(text: '$days일', style: DSTextStyles.bold14Black),
                        TextSpan(text: ' 운동했어요.', style: DSTextStyles.regular12WarmGrey),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '총 운동시간은 \n', style: DSTextStyles.regular12WarmGrey),
                        TextSpan(text: '$hours시간 $minutes분 $seconds초', style: DSTextStyles.bold14Black),
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
