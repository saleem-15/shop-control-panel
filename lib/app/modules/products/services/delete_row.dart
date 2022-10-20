import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';

/// returnes true if the product is deleted successfully
Future<bool> deleteProductService(String productId) async {
  try {
    final response = await dio.delete('$PRODUCT_PATH/$productId');

    CustomSnackbar.showCustomToast(
        message: 'The product was deleted succsfully');
    log(response.data.toString());
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: 'The product was not deleted');
    log(e.message);
    return false;
  }
}
