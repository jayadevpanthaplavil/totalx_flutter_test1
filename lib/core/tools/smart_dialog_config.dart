// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

// Project imports:
import '../../../core/constants/app_colors.dart';
import 'blur_background.dart';

Widget loadingBuilder(String message) {
  return BlurBackground(
    blur: 3,
    borderRadius: 12,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(Palette.primary),
          ),
          Visibility(
            visible: message.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showLoading(
    {String message = 'Loading...',
    bool backDismiss = false,
    Duration? displayTime}) {
  SmartDialog.showLoading(
      msg: message, backDismiss: backDismiss, displayTime: displayTime);
}

void dismissLoading() {
  SmartDialog.dismiss();
}

Widget toastBuilder(String message) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration:  BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.normal,
        ),
      ),
    ),
  );
}

void showToast(String message) {
  SmartDialog.dismiss();
  SmartDialog.showToast(
    message.toString(),
    displayTime: const Duration(milliseconds: 3000),
  );
}
