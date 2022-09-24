import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../app_components/custom_snackbar.dart';
import '../../../app_components/helpers.dart';
import '../../../constants/api_url.dart';

/// column index  determines what is changed (name,price,quantity)
/// returnes true if the product is updated successfully
Future<bool> updatProductService(String productId, int columnIndex, String newValue) async {
  log(productId);
  log('$columnIndex');

  late final Map<String, dynamic> queryParameters;

  switch (columnIndex) {
    case 1:
      break;
    case 2:
      queryParameters = {
        'price': newValue,
      };
      log('new price: $newValue');
      break;
    case 3:
      queryParameters = {
        'quantity': newValue,
      };
      log('new quantity: $newValue');

      break;
    case 4:
      break;
    case 5:
      queryParameters = {
        'sizes': [newValue],
      };
      log('new sizes: $newValue');
      break;
  }

  try {
    final response = await dio.put(
      '$PRODUCT_PATH/$productId',
      queryParameters: queryParameters,
      // data: formData,
    );
    //
    CustomSnackbar.showCustomToast(message: 'The product info was updated successfully!');
    log(response.data.toString());
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    return false;
  }
}
