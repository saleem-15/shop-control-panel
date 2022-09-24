import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/models/category.dart';
import 'package:shop_conrol_panel/screens/category/components/add_new_category_dialog.dart';
import 'package:shop_conrol_panel/screens/category/services/get_categories.dart';

import '../../app_components/custom_snackbar.dart';
import '../orders/components/actions.dart';
import 'services/add_new_category_service.dart';
import 'services/delete_category_service.dart';
import 'services/update_category_info.dart';

class CategoriesController extends GetxController {
  final RxBool isLoading = true.obs;
  RxBool dragging = false.obs;
  Rx<File?> image = null.obs;
  bool get isImageExists => image.value != null;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxList<Category> categories = <Category>[].obs;

  late PlutoGridStateManager stateManager;
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 130,
      title: 'Category Id',
      field: 'category_id',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      width: 150,
      title: 'Category Name',
      field: 'category_name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      width: 150,
      // frozen: PlutoColumnFrozen.end,

      enableColumnDrag: false,
      title: '',
      enableDropToResize: false,
      field: 'actions',
      type: PlutoColumnType.select(
        <String>['delete_button'],
        defaultValue: 'delete_button',
      ),
      renderer: (rendererContext) => DeleteButton(rendererContext: rendererContext),
    ),
  ];
  final List<PlutoRow> rows = [];

  @override
  Future<void> onReady() async {
    final categoriesData = await getCategoriesService();
    categories.addAll(convertJsonToCategories(categoriesData));
    isLoading(false);

    stateManager.appendRows(convertJsonToPlutoRows(categoriesData));
    stateManager.setShowLoading(false);

    super.onReady();
  }

  String? nameValidator(String? value) {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return 'required';
    }

    final isCategoryExists = categories.contains(name);

    if (isCategoryExists) {
      return 'Category Already Exits';
    }

    return null;
  }

  void deleteCategory(PlutoRow row) {
    stateManager.removeRows([row]);
    final categoryId = row.cells['category_id']!.value;
    deleteCategoryService(categoryId);
  }

  void addNewCategory() {
    if (image.value == null) {
      CustomSnackbar.showCustomErrorSnackBar(title: 'Error', message: 'Add an image first!!');
      return;
    }

    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    final name = nameController.text.trim();

    addNewCategoryService(image.value!, name);

    nameController.clear();
  }

  void onCellValueChanged(PlutoGridOnChangedEvent event) {
    final row = event.row!;
    final cell = row.cells['category_name']!;
    final int categoryId = row.cells['category_id']!.value;
    final String newValue = event.value;

    final isOnlyLettersAndWhiteSpace = RegExp('^[A-Za-z\\s]*\$').hasMatch(newValue);

    /// check if the new value is valid. if its not valid => (write the old value to the table & show error msg)
    if (newValue.trim().isEmpty) {
      CustomSnackbar.showCustomErrorSnackBar(
          title: 'Failed', message: 'Cannot have an empty category name!!');
      cell.value = event.oldValue;
      return;
    } else if (!isOnlyLettersAndWhiteSpace) {
      CustomSnackbar.showCustomErrorSnackBar(
        title: 'Failed',
        message: 'category name can only contains letters !!',
      );
      cell.value = event.oldValue;

      return;
    }

    updateCategoryInfo(categoryId, newValue);
  }

  onDragDone(DropDoneDetails detail) {
    final isNotImage = detail.files.any((file) => !file.path.isImageFileName);

    if (isNotImage) {
      CustomSnackbar.showCustomErrorSnackBar(title: 'Error', message: 'Not valid Image!!');
      return;
    }

    updateImage(detail);
  }

  void updateImage(DropDoneDetails detail) {
    image = File(detail.files.first.path).obs;
    update(['category_photo']);
  }

  onDragEntered(DropEventDetails detail) {
    dragging.value = true;
  }

  onDragExited(DropEventDetails detail) {
    dragging.value = false;
  }

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;
    if (stateManager.rows.isEmpty) {
      event.stateManager.setShowLoading(true);
    }
  }

  void deleteRow(PlutoRow row) {
    stateManager.removeRows([row]);
    final categoryId = row.cells['category_id']!.value;
    deleteCategoryService(categoryId);
  }

  void onFloatingActionButtonPressed() {
    Get.defaultDialog(title: '', content: const AddNewCategoryDialog());
  }
}
