import 'dart:io';

import 'package:my_workout_diary_app/global/bloc/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';

class FileProvider extends ParentProvider {
  Future<String> uploadFile(List<File> files) async {
    try {
      setStateBusy();
      String path = '/upload/file';

      var response = await ApiService().postMultiPart(path, files, 'file');
      ModelResponseGetRankers modelResponseGetRankers = ModelResponseGetRankers.fromMap(response);
      rankers = modelResponseGetRankers.data ?? [];
      setStateIdle();

      return true;
    } catch (e) {
      return false;
    }
  }
}
