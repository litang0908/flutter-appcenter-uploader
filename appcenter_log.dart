import 'package:qianji_flutter/utils/crash/appcenter/appcenter_log_exception.dart';

import 'appcenter_log_device.dart';

class AppCenterLog {
  static const LOG_TYPE_CRASH = "managedError";

  // static const LOG_TYPE_ERROR = "handledError";

  String type;
  DateTime timestamp;
  DateTime appLaunchTimestamp;

  AppCenterLogDevice device;

  String id;
  String processId;
  String processName = "";
  String userId;

  /// required boolean that indicates if the exception resulted in a crash
  bool fatal;
  AppCenterLogException exception;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "type": this.type,
      "timestamp": this.timestamp.toUtc().toString(),
      "appLaunchTimestamp": this.appLaunchTimestamp.toUtc().toString(),
      "id": this.id,
      "processId": this.processId,
      "processName": this.device?.appNamespace ?? this.processId,
      "userId": this.userId,
      "fatal": this.fatal,
      "device": this.device?.toJson()
    };
    if (this.exception != null) {
      json["exception"] = this.exception.toJson();
    }
    return json;
  }
}
