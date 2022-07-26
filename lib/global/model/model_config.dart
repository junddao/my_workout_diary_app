class ModelConfig {
  static final ModelConfig _manager = ModelConfig._internal();
  factory ModelConfig() {
    return _manager;
  }
  ModelConfig._internal();

  String apiProjectName = '';
  String serverCurruntType = '';
  String serverBaseUrl = '';

  void fromJson(Map<String, dynamic> json) {
    apiProjectName = json['api_project_name'];
    print('ApiProjectName : $apiProjectName');

    serverCurruntType = json['server_current_type'];
    print('serverCurrentType : $serverCurruntType');

    final serverInfoList = List.from(json['server_info']);
    print('serverInfoList : ${serverInfoList}');

    for (var countIndex = 0; countIndex < serverInfoList.length; ++countIndex) {
      final serverType = serverInfoList[countIndex]['type'];
      print('ServerType : $serverType');

      if (0 == serverCurruntType.compareTo(serverType)) {
        serverBaseUrl = serverInfoList[countIndex]['base_url'];
        print('countIndex : $countIndex');
      }
    }
  }
}
