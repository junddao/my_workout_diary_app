import 'package:my_workout_diary_app/global/model/user/model_response_me.dart';
import 'package:my_workout_diary_app/global/model/user/model_response_update.dart';
import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';

class UserProvider extends ParentProvider {
  ModelUser _me = ModelUser();

  ModelUser get me => _me;

  Future<bool> getMe() async {
    try {
      setStateBusy();
      const String path = '/user/me';
      Map<String, dynamic> response = await ApiService().get(path);
      ModelResponseMe modelResponseMe = ModelResponseMe.fromMap(response);
      _me = modelResponseMe.data!.first;
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProfile(ModelUser updatedMe) async {
    try {
      setStateBusy();
      const String url = '/user/update';
      Map<String, dynamic> result = await ApiService().post(url, updatedMe.toMap());
      ModelResponseUpdate modelResponseUpdate = ModelResponseUpdate.fromMap(result);
      if (modelResponseUpdate.success == false) {
        return false;
      }

      _me = modelResponseUpdate.data!.first;
      setStateIdle();

      return true;
    } catch (e) {
      return false;
    }
  }
}
