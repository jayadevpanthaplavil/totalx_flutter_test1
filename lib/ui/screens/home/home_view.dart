import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:totalx_flutter_test1/core/constants/ui_helpers.dart';
import 'package:totalx_flutter_test1/ui/shared/widgets/custom_text_form_field.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/assets.gen.dart';
import '../../../core/tools/debounce.dart';
import '../../../core/utils/utils.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        leading: emptyWidget,
        leadingWidth: 0,
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 15.sp,
            ),
            Text(
              'Nilambur',
              style: TextStyle(
                color: Palette.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height_10,
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: "search by name",
                    showLabel: false,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Image.asset(Assets.images.search.path),
                    ),
                    customBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.grey.withOpacity(0.30),
                      ),
                      borderRadius: BorderRadius.circular(36.r),
                    ),
                    onChanged: (value) {
                      Debounce(milliseconds: 800).run(() async {
                        printLog(
                          'Search key: $value',
                          name: 'CustomSearchBar',
                        );
                        viewModel.search(value.trim());
                      });
                    },
                  ),
                ),
                width_10,
                InkWell(
                    onTap: () {
                      viewModel.openFilter(context);
                    },
                    child: Transform.scale(
                        scale: 1.2,
                        child: SvgPicture.asset(Assets.images.svg.filter)))
              ],
            ),
            height_15,
            Text(
              'Users Lists',
              style: TextStyle(
                color: Palette.primary.withOpacity(0.70),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            height_5,
            (viewModel.tempUsers.isEmpty)
                ? Expanded(
                    child: Center(
                      child: Text(
                        'No user found, please add new user',
                        style: TextStyle(
                          color: Palette.primary.withOpacity(0.70),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
                      itemCount: viewModel.tempUsers.length ?? 0,
                      separatorBuilder: (context, index) => height_10,
                      itemBuilder: (context, index) {
                        var user = viewModel.tempUsers[index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: const Color(0x3F000000),
                                blurRadius: 4.r,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: user.pickedImage != null
                                          ? FileImage(
                                              File(user.pickedImage!.path),
                                            )
                                          : AssetImage(Assets
                                              .images
                                              .profilePlaceholder
                                              .path) as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                    ),
                                    shape: const CircleBorder()),
                              ),
                              width_10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.username ?? '',
                                    style: TextStyle(
                                      color: Palette.primary.withOpacity(0.80),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  height_5,
                                  Text(
                                    'Age: ${user.age ?? ''}',
                                    style: TextStyle(
                                      color: Palette.primary.withOpacity(0.80),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: SizedBox(
          width: 70.w, // Customize the width
          height: 70.h, // Customize the height
          child: RawMaterialButton(
            onPressed: () {
              viewModel.showCustomDialog(context);
            },
            fillColor: Palette.primary, // Use your custom color here
            shape: const CircleBorder(),
            elevation: 6.0,
            child: const Icon(
              Icons.add_rounded,
              size: 34.0, // Customize the icon size
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
