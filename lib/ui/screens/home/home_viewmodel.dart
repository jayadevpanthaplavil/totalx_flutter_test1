import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:totalx_flutter_test1/core/constants/app_constants.dart';
import 'package:totalx_flutter_test1/core/tools/smart_dialog_config.dart';
import 'package:totalx_flutter_test1/ui/screens/home/components/bottom_sheet.dart';

import '../../../model/filter_model.dart';
import '../../../model/user_model.dart';
import 'components/dialog.dart';

class HomeViewModel extends ChangeNotifier {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  List<UserModel> users = [];
  List<UserModel> tempUsers = [];
  String searchKey = "";

  List<FilterModel> filterList = [
    FilterModel(
      title: "All",
      type: FilterType.all,
      isSelected: true,
    ),
    FilterModel(
      title: "Age: Elder",
      type: FilterType.elder,
      isSelected: false,
    ),
    FilterModel(
      title: "Age: Younger",
      type: FilterType.younger,
      isSelected: false,
    ),
  ];

  void init() {
    updateList();
  }

  /// reset the list
  void updateList() {
    tempUsers = List.from(users);
    notifyListeners();
  }

  /// open filter sheet
  void openFilter(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        context: context,
        builder: (context) => FilterSheet(
              filterList: filterList,
              onConfirm: (value) {
                filterList = value;
                applyFilterAndSearch();
              },
            ));
  }

  /// open add new user dialog
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          nameController: _nameController,
          ageController: _ageController,
          onConfirm: (image) {
            if (image == null || image.path.isEmpty) {
              showToast("Please select an image.");
              return false;
            } else if (_nameController.text.isEmpty) {
              showToast("Please enter a name.");
              return false;
            } else if (_ageController.text.isEmpty) {
              showToast("Please enter an age.");
              return false;
            } else {
              users.add(UserModel(
                  username: _nameController.text,
                  age: int.parse(_ageController.text),
                  pickedImage: image));
              updateList();
              return true;
            }
          },
        );
      },
    );
    _nameController.clear();
    _ageController.clear();
  }

  /// search
  void search(String value) {
    searchKey = value;
    applyFilterAndSearch();
  }

  /// filter
  void applyFilterAndSearch() {
    FilterModel? selectedFilter = filterList.firstWhere(
        (filter) => filter.isSelected ?? false,
        orElse: () => FilterModel());

    List<UserModel> filteredUsers = users;

    if (selectedFilter.type != null) {
      switch (selectedFilter.type) {
        case FilterType.all:
          filteredUsers = users;
          break;
        case FilterType.elder:
          filteredUsers = users.where((user) => (user.age ?? 0) >= 60).toList();
          break;
        case FilterType.younger:
          filteredUsers = users.where((user) => (user.age ?? 0) < 60).toList();
          break;
      }
    }

    if (searchKey.isNotEmpty) {
      tempUsers = filteredUsers
          .where((user) =>
              user.username?.toLowerCase().contains(searchKey.toLowerCase()) ??
              false)
          .toList();
    } else {
      tempUsers = filteredUsers;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
