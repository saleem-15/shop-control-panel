import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_components/custom_snackbar.dart';

class CategoriesController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxList<String> categories = [
    'clothes',
    'electronics',
    'food',
    'cars',
  ].obs;

  RxBool dragging = false.obs;
  Rx<File?> image = null.obs;
  bool get isImageExists => image.value != null;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

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

  void addNewCategory() {
    if (image.value == null) {
      CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: 'Add an image first!!');
      return;
    }

    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    categories.add(nameController.text.trim());

    nameController.clear();
  }

  onDragDone(DropDoneDetails detail) {
    final isNotImage = detail.files.any((file) => !file.path.isImageFileName);

    if (isNotImage) {
      CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: 'Not valid Image!!');
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
}
