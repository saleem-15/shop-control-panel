import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/custom_snackbar.dart';

import '../../../constants/api_url.dart';

Future<void> deleteCategoryService(int categoryId) async {
  try {
    final response = await dio.delete('$CATEGORY_PATH/$categoryId');

    CustomSnackbar.showCustomToast(message: 'The category was deleted successfully');
    log(response.data.toString());
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: 'The category was not deleted');
    log(e.response!.data.toString());
  }
}
