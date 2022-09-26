import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/custom_snackbar.dart';
import 'package:shop_conrol_panel/app_components/helpers.dart';
import 'package:shop_conrol_panel/constants/api_url.dart';

/// returnes true if the product is deleted successfully
Future<bool> deleteshippingTypeService(String shippingTypeId) async {
  try {
    await dio.delete('$SHIPPING_TYPE_PATH/$shippingTypeId');

    CustomSnackbar.showCustomToast(message: 'The shipping Type was deleted succsfully');
    // log(response.data.toString());
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    log(e.message);
    return false;
  }
}
