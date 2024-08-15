import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:totalx_flutter_test1/core/constants/fonts.gen.dart';
import 'package:totalx_flutter_test1/core/constants/ui_helpers.dart';
import 'package:totalx_flutter_test1/core/tools/primary_button.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/assets.gen.dart';
import '../../shared/widgets/custom_text_form_field.dart';
import 'login_and_verify_otp_viewmodel.dart';

class LoginAndVerifyOtpView extends StatelessWidget {
  const LoginAndVerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [

            ],
          )

        ),
      ),
    );
  }
}

Widget loginView(){
  return   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        // viewModel.mobile = newValue?.trim() ?? '';
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
    PrimaryButton(onTap: (){},
        width: double.infinity,
        label: "Get OTP"
    )
  ]);
}
