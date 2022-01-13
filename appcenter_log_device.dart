class AppCenterLogDevice {
  static const _SDK_NAME = "appcenter.custom";
  static const _SDK_VERSION = "1.0.1";

  String appVersion;
  String appBuild;
  final String sdkName = _SDK_NAME;
  final String sdkVersion = _SDK_VERSION;
  String appNamespace;

  String osName;
  String osVersion;
  int osApiLevel;

  String model;
  String locale;
  String timeZoneOffset;
  String timeZone;

  String screenSize;
  String deviceId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "appVersion": this.appVersion,
      "appBuild": this.appBuild,
      "sdkName": this.sdkName,
      "sdkVersion": this.sdkVersion,
      "appNamespace": this.appNamespace,
      "osName": this.osName,
      "osVersion": this.osVersion,
      "osApiLevel": this.osApiLevel,
      "model": this.model,
      "locale": this.locale,
      "timeZoneOffset": this.timeZoneOffset,
      "timeZone": this.timeZone,
      "screenSize": this.screenSize,
      "deviceId": this.deviceId,
    };
    return json;
  }
}
