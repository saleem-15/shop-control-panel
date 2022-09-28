// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/add_shipping_type_service.dart';

class AddNewShippingTypeController extends GetxController {
  /// used to pop the dialog without poping any snackBars/toast
  late BuildContext dialogContext;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final minArrivalTimeController = TextEditingController();
  final maxArrivalTimeController = TextEditingController();

  String get name => nameController.text.trim();
  double get price => double.parse(priceController.text.trim());
  String get minArrivalTime => minArrivalTimeController.text.trim();
  String get maxArrivalTime => maxArrivalTimeController.text.trim();

  String? priceValidator(String? value) {
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

  String? minArrivalTimeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    if (!GetUtils.isNum(value)) {
      return 'Enter a number';
    }

    return null;
  }

  String? maxArrivalTimeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }

    if (!GetUtils.isNum(value)) {
      return 'Enter a number';
    }

    return null;
  }

  Future<void> addNewShippingType() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final isSuccessfullyAdded = await addNewShippingTypeService(name, price, minArrivalTime, maxArrivalTime);

    if (isSuccessfullyAdded) {
      Navigator.pop(dialogContext);
      clearAllFields();
    }
  }

  void setDialogContext(BuildContext context) {
    dialogContext = context;
  }

  void clearAllFields() {
    maxArrivalTimeController.clear();
    minArrivalTimeController.clear();
    priceController.clear();
    nameController.clear();
  }
}
