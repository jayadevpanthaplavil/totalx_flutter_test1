import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
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

/// common setAutoValidateMode
void setAutoValidateMode(dynamic viewModel) {
  viewModel.autoValidateMode = AutovalidateMode.always;
  viewModel.notifyListeners();
}

String maskMobileNumber(String mobileNumber) {
  if (mobileNumber.length < 2) {
    return mobileNumber; // Return as is if the number is too short to mask
  }

  // Replace all but the last 2 digits with 'X'
  return mobileNumber.replaceRange(0, mobileNumber.length - 2, 'X' * (mobileNumber.length - 2));
}

/// Format seconds to SS - used for timer in login screen
String formatSecondsToMMSS(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  return '${remainingSeconds.toString().padLeft(2, '0')} Sec';
}