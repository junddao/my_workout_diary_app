import 'dart:io';

import 'package:my_workout_diary_app/global/bloc/parent_provider.dart';
import 'package:my_workout_diary_app/global/model/upload/model_response_upload_file.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';

class FileProvider extends ParentProvider {
  Future<String?> uploadFile(List<File> files) async {
    try {
      setStateBusy();
      String path = '/upload/file';

      var response = await ApiService().postMultiPart(path, files, 'file');

      ModelResponseUploadFile modelResponseUploadFile = ModelResponseUploadFile.fromMap(response);
      String fileUrl = modelResponseUploadFile.data.first;
      setStateIdle();

      return fileUrl;
    } catch (e) {
      return null;
    }
  }
}
