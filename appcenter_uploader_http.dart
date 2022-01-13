//执行 http 请求

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qianji_flutter/utils/crash/appcenter/app_center_configs.dart';
import 'package:qianji_flutter/utils/crash/appcenter/appcenter_log.dart';

class AppCenterUploadHttp {
  static const _API = "https://in.appcenter.ms/logs?Api-Version=1.0.0";

  static Dio dioInstance;

  Future<Dio> _getDio({int timeOutInSec}) async {
    if (timeOutInSec != null && timeOutInSec > 0) {
      return await _buildDio(timeOutInSec: timeOutInSec);
    }
    if (dioInstance == null) {
      dioInstance = await _buildDio();
    }
    return dioInstance;
  }

  Future<Dio> _buildDio({int timeOutInSec}) async {
    int finalTimeOut = 15;
    BaseOptions options = new BaseOptions(
      baseUrl: _API,
      connectTimeout: finalTimeOut * 1000,
      receiveTimeout: finalTimeOut * 1000,
    );
    return Dio(options);
  }

  Future<bool> post(AppCenterLog log, String installID) async {
    try {
      String apkToken = await AppCenterConfigs.getApiToken();
      Dio dio = await _getDio();
      Options options = Options();
      options.headers = {
        "app-secret": apkToken,
        "install-id": installID,
        "Content-Type": "application/json"
      };

      debugPrint("======= AppCenterLog JSON ========");
      debugPrint(jsonEncode(log.toJson()));

      Map<String, dynamic> params = {
        "logs": [log.toJson()]
      };
      Response response = await dio.post(_API, data: params, options: options);
      debugPrint('post-result:url=${response.realUri}');
      // debugPrint('post-params:param=$params');

      return parseResponse(response);
    } on Exception catch (ex) {
      //发现部分解析会出现 FormatException
      print(ex);
      return false;
    }
  }

  bool parseResponse(Response response) {
    debugPrint("AppCenter upload Response:$response");
    if (response != null && response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        var dataMap = response.data as Map<String, dynamic>;
        return dataMap.containsKey("status") && dataMap["status"] == 'Success';
      }
    }
    return false;
  }
}
