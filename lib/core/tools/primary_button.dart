import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../constants/ui_helpers.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.label,
    this.child,
    required this.onTap,
    this.width,
    this.height = 44,
    this.elevation,
    this.style,
    this.color,
    this.hapticFeedback = true,
    this.loading = false,
    this.labelColor,
    this.icon,
    this.iconColor,
    this.loadingColor,
    this.borderSide,
    this.suffixIcon, this.decoration,
  });
  final String? label;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? elevation;
  final TextStyle? style;
  final String? icon;
  final String? suffixIcon;
  final Color? iconColor;
  final Color? loadingColor;
  final BorderSide? borderSide;
  final Color? color;
  final Color? labelColor;
  final bool hapticFeedback;
  final bool loading;
  final Widget? child;
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration:decoration ?? ShapeDecoration(
        color: color ?? Palette.primary,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.r),
        ),
      ),
      child: MaterialButton(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.r),
        ),
        height: height,
        minWidth: width,
        padding: loading ? EdgeInsets.zero : null,
        onPressed: loading
            ? null
            : () async {
                try {
                  if (
                      hapticFeedback == true && Platform.isIOS ||
                      hapticFeedback == true && Platform.isAndroid) {
                    await HapticFeedback.vibrate();
                  }
                } catch (e) {
                  log(e.toString());
                } finally {
                  onTap.call();
                }
              },
        color: color,
        elevation: elevation,
        child: Visibility(
          visible: !loading,
          replacement: Container(
            width: width,
            height: height,
            color: Palette.white.withOpacity(0.3),
            alignment: Alignment.center,
            child: SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                color: loadingColor ?? Palette.white,
                strokeWidth: 1.5,
              ),
            ),
          ),
          child: (child != null && label != null)
              ? ErrorWidget("child != null || label != null) ")
              : child ??
                  (label != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (icon != null) ...[
                              SvgPicture.asset(
                                icon ?? '',
                                color: iconColor ?? Palette.white,
                              ),
                              width_5,
                            ],
                            Flexible(
                              child: Text(
                                label ?? "",
                                style: style ??
                                    TextStyle(
                                      color: labelColor ?? Palette.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (suffixIcon != null) ...[
                              width_5,
                              SvgPicture.asset(
                                suffixIcon ?? '',
                                color: Palette.white,
                              ),
                            ],
                          ],
                        )
                      : ErrorWidget("child === null && label == null  ) ")),
        ),
      ),
    );
  }
}
