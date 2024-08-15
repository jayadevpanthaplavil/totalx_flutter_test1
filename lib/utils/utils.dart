import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

String getDeviceType() {
  String deviceType = '';
  if (Platform.isAndroid) {
    deviceType = '1';
  } else if (Platform.isIOS) {
    deviceType = '2';
  }
  return deviceType;
}

void printLog(value, {mode = kDebugMode, name = ''}) {
  switch (mode) {
    case kDebugMode:
      dev.log("$value", name: name);
      break;
    case kReleaseMode:
      dev.log("$value");
      break;
    case kIsWeb:
      dev.log("$value");
      break;
    case kProfileMode:
      dev.log("$value");
      break;
    default:
      dev.log('PrintLog: no mode selected');
  }
}