import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/fonts.gen.dart';
import '../../../core/constants/ui_helpers.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.textColor = Palette.blackTextColor,
    this.fontSize = 14,
    this.mandatory = false,
    this.hintTextColor,
    this.hintFontSize,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.initialValue,
    this.controller,
    this.label,
    this.showLabel = true,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.isDense = false,
    this.labelIcon,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.prefixIconConstraints, //const BoxConstraints(minWidth: 0,),
    this.suffixIconConstraints, //const BoxConstraints(minWidth: 0,),
    this.customBorder,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.labelStyle,
    this.labelSpacing = 16,
    this.showLabelAsHint = true,
  });
  final String? hintText;
  final Color textColor;
  final double fontSize;
  final TextStyle? labelStyle;
  final bool mandatory;
  final Color? hintTextColor;
  final double? hintFontSize;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final String? initialValue;
  final bool showLabel;
  final String? label;
  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? maxLength;
  final bool isDense;
  final Widget? labelIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final InputBorder? customBorder;
  final EdgeInsets scrollPadding;
  final double labelSpacing;
  final bool showLabelAsHint;

  ///[FilteringTextInputFormatter]allow only specific characters, numbers, or patterns while disallowing others [clear already entered text]
  ///
  ///Eg:- FilteringTextInputFormatter.digitsOnly, [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
  ///
  ///[LengthLimitingTextInputFormatter] - set length
  ///
  /// methods->
  /// [TextInputFormatter] is an abstract class that you can extend to create custom input formatters tailored to your specific needs. By overriding the formatEditUpdate method, you can control how the input text is modified.
  /// [Custom Input Formatters]
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Palette.grey,
      ),
      borderRadius: BorderRadius.circular(8.r),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Palette.primary,
      ),
      borderRadius: BorderRadius.circular(8.r),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        showLabel
            ? LabelWidget(
          labelLeftPadding: 8.w,
                mandatory: mandatory,
                label: label,
                labelStyle: labelStyle,
                textColor: textColor,
                labelIcon: labelIcon)
            : emptyWidget,
        if (showLabel) verticalSpace(labelSpacing.h),
        TextFormField(
          scrollPadding: scrollPadding,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isDense: isDense,
              border: customBorder ?? border,
              enabledBorder: customBorder ?? border,
              disabledBorder: customBorder ?? border,
              focusedBorder: customBorder ??focusedBorder,
              label: (showLabel && showLabelAsHint)
                  ? LabelWidget(
                      mandatory: true,
                      label: label,
                      labelStyle: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                      textColor: Palette.grey)
                  : null,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: hintFontSize ?? 14.sp,
                fontWeight: FontWeight.w400,
                color: hintTextColor ?? Palette.grey,
              ),
              suffixIcon: suffixIcon,
              suffixIconConstraints: suffixIconConstraints,
              prefixIcon: prefixIcon,
              prefix: prefix,
              prefixIconConstraints: prefixIconConstraints),
          style: TextStyle(
            color: Palette.blackTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          initialValue: initialValue,
          controller: controller,

        ),
      ],
    );
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget(
      {super.key,
      this.labelIcon,
      this.labelLeftPadding,
      this.label,
      this.labelStyle,
      this.textColor, this.mandatory = false});
  final Widget? labelIcon;
  final double? labelLeftPadding;
  final String? label;
  final TextStyle? labelStyle;
  final Color? textColor;
  final bool mandatory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        labelIcon ?? emptyWidget,
        horizontalSpace(labelLeftPadding ?? 0),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label ?? '',
                style: labelStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontFamily: FontFamily.montserrat,
                    ),
              ),
              TextSpan(
                text: mandatory ? ' *' : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.montserrat,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
