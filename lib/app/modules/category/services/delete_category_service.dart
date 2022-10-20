import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

/// returnes true if the category is deleted successfully
Future<bool> deleteCategoryService(int categoryId) async {
  try {
    final response = await dio.delete('$CATEGORY_PATH/$categoryId');

    CustomSnackbar.showCustomToast(
        message: 'The category was deleted successfully');
    log(response.data.toString());
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(
        message: formatErrorMsg(e.response!.data));
    //'The category was not deleted'
    log(e.response!.data.toString());
    return false;
  }
}

mixin CATEGORY_PATH {}
