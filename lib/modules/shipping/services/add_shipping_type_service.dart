import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/custom_snackbar.dart';
import 'package:shop_conrol_panel/app_components/helpers.dart';

import '../../../constants/api.dart';

/// returnes true if the shipping type is added successfully
Future<bool> addNewShippingTypeService(
    String name, double price, String minArrivalTime, String maxArrivalTime) async {
  try {
    await dio.post(
      SHIPPING_TYPE_PATH,
      queryParameters: {
        'title': name,
        'price': price,
        'minNumberDaysToArrival': minArrivalTime,
        'maxNumberDaysToArrival': maxArrivalTime,
      },
    );
    //
    CustomSnackbar.showCustomToast(message: 'The shipping type was added successfully!');
    // log(response.data.toString());
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    return false;
  }
}
