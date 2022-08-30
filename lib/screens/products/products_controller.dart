import 'dart:developer';
import 'dart:io';

import 'package:desktop_drop/src/drop_target.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_components/custom_snackbar.dart';

class ProductsController extends GetxController {
  final List<File> list = <File>[].obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final categories = [
    'clothes',
    'electronics',
    'food',
  ];

  RxBool dragging = false.obs;

  late final RxString chosenCategory;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final colorController = TextEditingController();
  final sizeController = TextEditingController();

  final colors = <int>[].obs;
  final sizes = <String>[].obs;

  @override
  void onInit() {
    chosenCategory = categories.first.obs;
    super.onInit();
  }

  void addNewColor() {
    String colorValue = colorController.text.trim();

    if (colorValue.isEmpty) {
      return;
    }

    RegExp colorRegex = RegExp('^#(?:[0-9a-fA-F]{3}){1,2}\$');
    final isValidColorString = colorRegex.hasMatch(colorValue);

    if (!isValidColorString) {
      CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: 'Not valid hex color value');
      return;
    }

    colorValue = colorValue.replaceFirst('#', '0xff');
    colors.add(int.parse(colorValue));
    colorController.clear();
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    return null;
  }

  String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    return null;
  }

  void addNewSize() {
    final size = sizeController.text.trim();
    if (size.isEmpty) {
      return;
    }

    sizes.add(size);
    sizeController.clear();
  }

  //
  onDragDone(DropDoneDetails detail) {
    final isNotImage = detail.files.any((file) => !file.path.isImageFileName);

    if (isNotImage) {
      CustomSnackBar.showCustomErrorSnackBar(title: 'Error', message: 'Not valid Image!!');
      return;
    }

    addImages(detail);

    for (var element in list) {
      log(element.path);
    }
    log(list.length.toString());
  }

  void addImages(DropDoneDetails detail) => list.addAll(detail.files.map((e) => File(e.path)));

  onDragEntered(DropEventDetails detail) {
    dragging.value = true;
  }

  onDragExited(DropEventDetails detail) {
    dragging.value = false;
  }
}
