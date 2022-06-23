import 'package:my_workout_diary_app/global/model/user/model_response_me.dart';
import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';

class UserProvider extends ParentProvider {
  ModelUser me = ModelUser();

  Future<bool> getMe() async {
    try {
      setStateBusy();
      const String path = '/user/me';
      Map<String, dynamic> response = await ApiService().get(path);
      ModelResponseMe modelResponseMe = ModelResponseMe.fromMap(response);
      me = modelResponseMe.data!.first;
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }
}
