import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/constants/api.dart';

import '../../../app_components/custom_snackbar.dart';
import '../../../app_components/helpers.dart';

///returnes true if the category was updated successfully
Future<bool> updateCategoryInfo(int categoryId, String newValue) async {
  try {
    await dio.put(
      '$CATEGORY_PATH/$categoryId',
      queryParameters: {'name': newValue},
    );
    CustomSnackbar.showCustomToast(message: 'The category was updated successfully');
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    return false;
  }
}
