import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx_flutter_test1/core/constants/ui_helpers.dart';
import 'package:totalx_flutter_test1/core/tools/primary_button.dart';
import 'package:totalx_flutter_test1/ui/shared/widgets/custom_text_form_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/assets.gen.dart';

class CustomDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final bool Function(XFile? image) onConfirm;

  const CustomDialog({super.key,
    required this.nameController,
    required this.ageController,
    required this.onConfirm,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;

  void onImagePicker() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = image;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add A New User',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          height_20,
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: 1.1,
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Container(
                      width: 85.w,
                      height: 85.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: pickedImage != null
                              ? FileImage(
                                  File(pickedImage!.path),
                                )
                              : AssetImage(
                                      Assets.images.profilePlaceholder.path)
                                  as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: onImagePicker,
                  child: Transform.scale(
                      scale: 1.2,
                      child: Image.asset(Assets.images.profileEdit.path)))
            ],
          ),
          height_15,
          CustomTextFormField(
            labelSpacing: 8,
            showLabelAsHint: false,
            hintText: "Name",
            controller: widget.nameController,
            label: "Name",
            labelStyle: TextStyle(
              color: Palette.blackTextColor.withOpacity(0.60),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          height_15,
          CustomTextFormField(
            labelSpacing: 8,
            showLabelAsHint: false,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            hintText: "Age",
            controller: widget.ageController,
            label: "Age",
            labelStyle: TextStyle(
              color: Palette.blackTextColor.withOpacity(0.60),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          height_20,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PrimaryButton(
                decoration: ShapeDecoration(
                  color: const Color(0xFFCCCCCC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                style: TextStyle(
                  color: Palette.blackTextColor.withOpacity(0.50),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                label: "Cancel",
                width: 95.w,
                height: 30.h,
              ),
              width_10,
              PrimaryButton(
                decoration: ShapeDecoration(
                  color: const Color(0xFF1781FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                onTap: () {
                  bool result = widget.onConfirm(pickedImage);
                  if (result) {
                    Navigator.pop(context);
                  } else {
                    // Optionally, you can show an error message here if validation fails
                  }
                },
                label: "Save",
                width: 95.w,
                height: 30.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
