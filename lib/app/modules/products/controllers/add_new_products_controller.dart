import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/custom_snackbar.dart';
import '../../../models/category.dart';
import '../../category/services/get_categories.dart';
import '../services/add_new_product_service.dart';
import 'images_controller.dart';

class AddNewProductsController extends GetxController {
  final imagesController = Get.put(ImagesController());
  // if categories is loading
  late final RxBool isLoading = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Function() goToProducts;

  late final RxList<Category> categories;
  //  <Category>[].obs;
  late final RxString chosenCategory;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final colorController = TextEditingController();
  final sizeController = TextEditingController();
  final quantityController = TextEditingController();

  String get name => nameController.text.trim();
  String get categoryId =>
      categories.firstWhere((element) => element.name == chosenCategory.value).id.toString();

  String get size => sizeController.text.trim();
  String get colorString => colorController.text.trim();

  String get description => descriptionController.text.trim();
  double get price => double.parse(priceController.text.trim());
  int get quantity => int.parse(quantityController.text.trim());
  List<File> get images => imagesController.imagesList;

  final colors = <String>[].obs;
  final sizes = <String>[].obs;

  @override
  Future<void> onReady() async {
    await initCategories();
    super.onReady();
  }

  void addNewColor() {
    /// Not Empty
    if (colorString.isEmpty || colorString.isBlank!) {
      CustomSnackbar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'cannot have empty color',
      );
      return;
    }

    /// Valid Color value
    RegExp colorRegex = RegExp('^(?:[0-9a-fA-F]{3}){1,2}\$');
    final isValidColorString = colorRegex.hasMatch(colorString);

    if (!isValidColorString) {
      CustomSnackbar.showCustomErrorSnackBar(title: 'Error', message: 'Not valid hex color value');
      return;
    }

    /// New Color value
    final isAlreadyExists = colors.any((color) => color == colorString);
    if (isAlreadyExists) {
      CustomSnackbar.showCustomErrorSnackBar(title: 'Error', message: 'The color Already Exists!');
      return;
    }

    // colors.add(int.parse('0x$colorString'));
    colors.add(colorString);
    colorController.clear();
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    if (!GetUtils.isNum(value)) {
      return 'Enter a number';
    }

    return null;
  }

  String? quantityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    if (!GetUtils.isNum(value)) {
      return 'Enter a number';
    }

    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    if (GetUtils.isNum(value)) {
      return 'The name can\'t be a number';
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
    if (size.isEmpty) {
      return;
    }

    sizes.add(size);
    sizeController.clear();
  }

  Future<void> addNewProduct() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final isSuccessfullyAdded =
        await addNewProductService(categoryId, name, price, quantity, description, colors, sizes, images);

    if (isSuccessfullyAdded) {
      clearAllFields();
    }
  }

  void clearAllFields() {
    quantityController.clear();
    sizeController.clear();
    colorController.clear();
    descriptionController.clear();
    priceController.clear();
    nameController.clear();
    colors.clear();
    sizes.clear();

    imagesController.clearImagesList();
  }

  Future<void> initCategories() async {
    final categoriesData = await getCategoriesService();
    categories = [...convertJsonToCategories(categoriesData)].obs;
    chosenCategory = categories.first.name.obs;
    isLoading(false);
  }

  void initCategoriesList() {
    // final cateogiresController = Get.find<CategoriesController>();

    // isLoading = cateogiresController.isLoading;

    // categories = cateogiresController.getCategoriesList;

    // isLoading.listen((isLoadingValue) {
    //   if (isLoadingValue == false) {
    //     return;
    //   }
    //   if (categories.isNotEmpty) {
    //     chosenCategory = categories.first.name.obs;
    //   }
    // });

    /// if categories are already loaded
    // if (cateogiresController.isLoading.isFalse) {
    //   categories.addAll(cateogiresController._categories);
    //   chosenCategory = categories.first.name.obs;
    // } else {
    //   ever(
    //     cateogiresController.isLoading,
    //     // this function will be called when (cateogiresController.isLoading) becomes '''TRUE'''
    //     (callback) {
    //       categories.addAll(cateogiresController._categories);
    //       chosenCategory = categories.first.name.obs;
    //       isLoading(false);
    //     },
    //   );
    // }
  }
}
