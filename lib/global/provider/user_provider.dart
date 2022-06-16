import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';

class UserProvider extends ParentProvider {
  ModelUser me = ModelUser();

  Future<bool> getMe() async {
    try {
      setStateBusy();
      const String path = '/auth/me';
      Map<String, dynamic> response = await ApiService().get(path);
      me = ModelUser.fromMap(response);
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }
}
