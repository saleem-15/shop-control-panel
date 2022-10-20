import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

/// column index  determines what is changed (name,price,min/max arrival time)
/// returnes true if the product is updated successfully
Future<bool> updateShippingTypeService(
    String shippingTypeId, String columnId, String newValue) async {
  final queryParameters = {columnId: newValue};

  try {
    await dio.put(
      '$SHIPPING_TYPE_PATH/$shippingTypeId',
      queryParameters: queryParameters,
    );
    //
    CustomSnackbar.showCustomToast(
      message: 'The Shipping type info was updated successfully!',
    );
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(
      message: formatErrorMsg(e.response!.data),
    );
    log(e.response!.data.toString());
    return false;
  }
}
