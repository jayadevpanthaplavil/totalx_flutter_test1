import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:totalx_flutter_test1/core/constants/ui_helpers.dart';
import 'package:totalx_flutter_test1/core/tools/primary_button.dart';
import 'package:totalx_flutter_test1/core/utils/utils.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/assets.gen.dart';
import '../../shared/widgets/custom_text_form_field.dart';
import 'login_and_verify_otp_viewmodel.dart';

class LoginAndVerifyOtpView extends StatelessWidget {
  const LoginAndVerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginAndVerifyOtpViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPress(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: viewModel.isLoginScreen
                  ? loginView(viewModel, context)
                  : verifyOtpView(viewModel, context)),
        ),
      ),
    );
  }
}

/// LOGIN VIEW
Widget loginView(LoginAndVerifyOtpViewModel viewModel, BuildContext context) {
  return Form(
    autovalidateMode: viewModel.autoValidateMode,
    key: viewModel.formKey,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      verticalSpace(60.h),
      Align(
        alignment: Alignment.center,
        child: Assets.images.login.image(),
      ),
      height_50,
      CustomTextFormField(
        label: 'Enter Phone Number',
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
        ],
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Mobile number is required';
          } else if (value?.length != 10) {
            return "Not a valid phone number (required 10 digits)";
          }
          return null;
        },
        onSaved: (newValue) {
          viewModel.mobile = newValue?.trim() ?? '';
        },
      ),
      height_15,
      Opacity(
        opacity: 0.50,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'By Continuing, I agree to TotalX’s ',
                style: TextStyle(
                  color: Palette.blackTextColor,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'Terms and condition',
                style: TextStyle(
                  color: Palette.blue,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' & ',
                style: TextStyle(
                  color: Palette.blackTextColor,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'privacy policy',
                style: TextStyle(
                  color: Palette.blue,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      height_25,
      PrimaryButton(
          onTap: viewModel.isResendOtpBusy
              ? () {}
              : () => viewModel.onSubmit(viewModel, context),
          loading: viewModel.isBusy,
          width: double.infinity,
          label: "Get OTP"),
      height_100,
    ]),
  );
}

/// VERIFY OTP VIEW
Widget verifyOtpView(
    LoginAndVerifyOtpViewModel viewModel, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      height_40,
      Align(
        alignment: Alignment.center,
        child: Assets.images.verifyOtp.image(),
      ),
      height_30,
      Text(
        'OTP Verification',
        style: TextStyle(
          color: Palette.blackTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      height_25,
      Opacity(
          opacity: 0.70,
          child: Text(
            'Enter the verification code we just sent to your number +91 ${maskMobileNumber(viewModel.mobile)}.',
            style: TextStyle(
              color: Palette.blackTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          )),
      height_25,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: PinInputTextFormField(
          controller: viewModel.otpController,
          pinLength: 6,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          decoration: BoxLooseDecoration(
            textStyle: TextStyle(
              color: Palette.red,
              fontSize: 18.sp,
              fontFamily: 'Rethink Sans',
              fontWeight: FontWeight.w700,
            ),
            radius: Radius.circular(8.r),
            strokeColorBuilder: PinListenColorBuilder(
              Palette.primary,
              Palette.grey,
            ),
            gapSpace: 8.w,
          ),
          onChanged: (value) {
            viewModel.updateOtp(value);
          },
          onSubmit: (value) {
            viewModel.updateOtp(value);
            viewModel.onSubmit(viewModel, context);
          },
        ),
      ),
      if (!viewModel.enableResend) ...[
        height_15,
        Align(
          alignment: Alignment.center,
          child: Text(
            " ${formatSecondsToMMSS(viewModel.secondsRemaining)}",
            style: TextStyle(
              color: Palette.red,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      height_25,
      if (viewModel.enableResend) ...[
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Don't Get OTP? ",
                  style: TextStyle(
                    color: Palette.blackTextColor,
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      viewModel.enableResend
                          ? await viewModel.resendOtpApi()
                          : () {};
                    },
                  text: 'Resend',
                  style: TextStyle(
                    color: Palette.blue,
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        height_15,
      ],
      PrimaryButton(
        width: double.infinity,
        label: 'Verify',
        onTap: viewModel.isResendOtpBusy
            ? () {}
            : () => viewModel.onSubmit(viewModel, context),
        loading: viewModel.isBusy,
      ),
      height_100
    ],
  );
}
