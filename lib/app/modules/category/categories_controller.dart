import 'dart:io';

import 'package:flutter/material.dart';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../utils/custom_snackbar.dart';
import '../../models/category.dart';
import '../../shared/actions.dart';
import 'components/add_new_category_dialog.dart';
import 'services/add_new_category_service.dart';
import 'services/delete_category_service.dart';
import 'services/get_categories.dart';
import 'services/update_category_info.dart';

// ignore_for_file: use_build_context_synchronously

class CategoriesController extends GetxController {
  final RxBool isLoading = true.obs;
  RxBool dragging = false.obs;
  Rx<File?> image = null.obs;
  bool get isImageExists => image.value != null;

  final nameController = TextEditingController();
  String get name => nameController.text.trim();

  late final GlobalKey<FormState> formKey;

  /// used to pop the dialog without poping any snackBars/toast
  final dialogKey = GlobalKey();

  final RxList<Category> _categories = <Category>[].obs;

  bool isStateManagerInitialized = false;
  late PlutoGridStateManager stateManager;
  late final List<PlutoColumn> columns;
  final List<PlutoRow> rows = [];

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    columns = <PlutoColumn>[
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
        enableColumnDrag: false,
        title: '',
        enableDropToResize: false,
        field: 'actions',
        type: PlutoColumnType.select(
          <String>['delete_button'],
          defaultValue: 'delete_button',
        ),
        renderer: (rendererContext) => DeleteButton(
          rendererContext: rendererContext,
          deleteRow: deleteRow,
        ),
      ),
    ];
  }

  String? nameValidator(String? value) {
    final name = nameController.text.trim();
    if (value == null || name.isEmpty) {
      return 'required';
    }

    final isValidName = isValidCategoryName(value);
    if (!isValidName) {
      return 'Not valid name';
    }

    return null;
  }

  Future<void> deleteCategory(PlutoRow row) async {
    final categoryId = row.cells['category_id']!.value;
    final isDeleted = await deleteCategoryService(categoryId);

    if (isDeleted) {
      stateManager.removeRows([row]);
    }
  }

  Future<bool> addNewCategory() async {
    if (image.value == null) {
      CustomSnackbar.showCustomErrorSnackBar(title: 'Error', message: 'Add an image first!!');
      return false;
    }

    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final isAddedSuccessfully = await addNewCategoryService(image.value!, name);

    if (isAddedSuccessfully) {
      nameController.clear();
      return true;
    }

    return false;
  }

  Future<void> onCellValueChanged(PlutoGridOnChangedEvent event) async {
    final row = event.row!;
    final cell = row.cells['category_name']!;
    final int categoryId = row.cells['category_id']!.value;
    final String newValue = event.value;

    final isValidName = isValidCategoryName(newValue);

    if (!isValidName) {
      /// if the new value is not valid => (write the old value to the table)
      cell.value = event.oldValue;
      return;
    }
    final isUpdated = await updateCategoryInfo(categoryId, newValue);

    /// if the new value is not updated on server => (write the old value to the table)
    if (!isUpdated) {
      cell.value = event.oldValue;
      return;
    }
  }

  /// checks if the string is a valid category name.
  /// it shows error messages explaining the error.
  bool isValidCategoryName(String name) {
    /// not empty
    if (name.trim().isEmpty) {
      CustomSnackbar.showCustomErrorSnackBar(
        title: 'Failed',
        message: 'Cannot have an empty category name!!',
      );
      return false;
    }

    /// not Already used
    final bool isCategoryExists = _categories.any((category) => category.name == name);

    if (isCategoryExists) {
      CustomSnackbar.showCustomErrorSnackBar(
        title: 'Failed',
        message: 'Category name Already Exits',
      );
      return false;
    }

    final isOnlyLettersAndWhiteSpace = RegExp('^[A-Za-z\\s]*\$').hasMatch(name);

    /// only letters and spaces
    if (!isOnlyLettersAndWhiteSpace) {
      CustomSnackbar.showCustomErrorSnackBar(
        title: 'Failed',
        message: 'category name can only contains letters !!',
      );
      return false;
    }
    return true;
  }

  onDragDone(DropDoneDetails detail) {
    final isNotImage = detail.files.any((file) => !file.path.isImageFileName);

    if (isNotImage) {
      CustomSnackbar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Not valid Image!!',
      );
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

  Future<void> onPlutoGridInit(PlutoGridOnLoadedEvent event) async {
    stateManager = event.stateManager;

    if (!isStateManagerInitialized) {
      initCategories();
    }
    isStateManagerInitialized = true;
  }

  Future<void> deleteRow(PlutoRow row) async {
    final categoryId = row.cells['category_id']!.value;
    final isDeleted = await deleteCategoryService(categoryId);

    if (isDeleted) {
      stateManager.removeRows([row]);
    }
  }

  void onFABPressed() {
    Get.dialog(
      Center(
        child: AddNewCategoryDialog(
          key: dialogKey,
        ),
      ),
    );
  }

  Future<void> onAddNewCategoryButtonPressed() async {
    final isAddedSuccessfully = await addNewCategory();

    if (isAddedSuccessfully) {
      /// pop the [AddNewCategoryDialog] dialog
      Navigator.pop(dialogKey.currentContext!);
    }
  }



  Future<void> initCategories() async {
    stateManager.setShowLoading(true);

    final categoriesData = await getCategoriesService();
    _categories.addAll(convertJsonToCategories(categoriesData));
    isLoading(false);

    stateManager
      ..appendRows(convertJsonToPlutoRows(categoriesData))
      ..setShowLoading(false);
  }

  RxList<Category> get getCategoriesList {
    return _categories;
  }

  void refreshCategories() {
    stateManager.removeAllRows();
    initCategories();
  }
}
