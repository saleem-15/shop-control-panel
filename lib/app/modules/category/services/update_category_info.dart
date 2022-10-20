import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

///returnes true if the category was updated successfully
Future<bool> updateCategoryInfo(int categoryId, String newValue) async {
  try {
    await dio.put(
      '$CATEGORY_PATH/$categoryId',
      queryParameters: {'name': newValue},
    );
    CustomSnackbar.showCustomToast(
      message: 'The category was updated successfully',
    );
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
