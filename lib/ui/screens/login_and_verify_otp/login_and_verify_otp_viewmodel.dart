import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/tools/smart_dialog_config.dart';
import '../../../core/utils/routes/route_names.dart';
import '../../../core/utils/utils.dart';

class LoginAndVerifyOtpViewModel extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String mobile = '';
  String otpString = '';
  TextEditingController otpController = TextEditingController();
  bool isLoginScreen = true;
  Timer? timer;
  int secondsRemaining = 30;
  bool enableResend = false, showResendOtp = false;

  bool _isBusy = false;
  bool _isResendOtpBusy = false;

  bool get isBusy => _isBusy;
  bool get isResendOtpBusy => _isResendOtpBusy;

  /// set busy status
  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  /// set resend otp busy status
  void setResendOtpBusy(bool value) {
    _isResendOtpBusy = value;
    notifyListeners();
  }

  /// on back press
  void onBackPress(context) {
    if (timer?.isActive == true) {
      timer?.cancel();
    }
    if (!isLoginScreen) {
      otpController.clear();
      enableResend = false;
      showResendOtp = false;
      isLoginScreen = true;
    } else {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  /// onChanged - otp field
  void updateOtp(String value) {
    debugPrint('onChanged OTP $value');
    otpString = value;
    notifyListeners(); // Notify listeners of the change
  }

  /// on submit - primary button
  Future<void> onSubmit(
      LoginAndVerifyOtpViewModel viewModel, BuildContext context) async {
    setBusy(true);
    try {
      if (isLoginScreen) {
        /// validate form
        if (formKey.currentState?.validate() ?? false) {
          formKey.currentState?.save();
          await loginApi();
        } else {
          setAutoValidateMode(viewModel);
        }
      } else {
        if ((otpString.length == 6) /*&& otpString == '123456'*/) {
          verifyOtpApi(context);
        } else {
          showToast('Invalid OTP');
        }
      }
    } finally {
      setBusy(false);
    }
  }

  /// call api login
  Future<void> loginApi() async {
    isLoginScreen = false;
    notifyListeners();
    startTimer();
  }

  /// start timer - resend otp
  void startTimer() {
    secondsRemaining = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        enableResend = true;
        notifyListeners();
      }
    });
  }

  /// call api verify otp
  Future<void> verifyOtpApi(context) async {
    Navigator.pushNamed(context, RouteNames.home).then((value) {
      if (value != null) {
        otpController.clear();
        enableResend = false;
        showResendOtp = false;
        isLoginScreen = true;
        notifyListeners();
      }
    });
  }

  /// call api resend
  Future<void> resendOtpApi() async {
    setResendOtpBusy(true);
    try {
      showResendOtp = true;
      otpController.clear();
      notifyListeners();
      try {
        bool status = true;
        if (status) {
          secondsRemaining = 30;
          enableResend = false;
          showResendOtp = false;
          notifyListeners();
        } else {
          showResendOtp = false;
          notifyListeners();
        }
      } catch (e) {
        showResendOtp = false;
        notifyListeners();
      }
    } finally {
      setResendOtpBusy(false);
    }
  }

  @override
  dispose() {
    if (timer?.isActive == true) {
      timer?.cancel();
    }
    otpController.dispose();
    super.dispose();
  }
}
