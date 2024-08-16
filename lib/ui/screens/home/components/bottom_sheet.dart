import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:totalx_flutter_test1/core/constants/ui_helpers.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/assets.gen.dart';
import '../../../../model/filter_model.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, required this.filterList, required this.onConfirm});
  final List<FilterModel> filterList;
  final void Function(List<FilterModel> filterList) onConfirm;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: ShapeDecoration(
        color: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
      ),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sort',
            style: TextStyle(
              color: Palette.blackTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          height_20,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.filterList.length ?? 0,
            separatorBuilder: (context, index) => height_20,
            itemBuilder: (context, index) {
              var item = widget.filterList[index];
              return FilterItem(filter: item,
              select: () {
                setState(() {
                  // Ensure only the selected item is marked as true, others as false
                  for (var filter in widget.filterList) {
                    filter.isSelected = false;
                  }
                  item.isSelected = true;
                });
                widget.onConfirm(widget.filterList);
                Navigator.pop(context);
              }
              );
            },
          )
        ],
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, this.filter, this.select});
  final FilterModel? filter;
  final void Function()? select;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: select,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset((filter?.isSelected ?? false)
              ? Assets.images.svg.radioOn
              : Assets.images.svg.radioOff),
          width_15,
          Expanded(
            child: Text(
              filter?.title ?? '',
              style: TextStyle(
                color: Palette.blackTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
