import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/helpers.dart';

import '../../../app_components/custom_snackbar.dart';
import '../../../constants/api_url.dart';

///returnes true if the category was added successfully
Future<bool> addNewCategoryService(File image, String name) async {
  try {
    FormData data = FormData.fromMap({
      'name': name,
      'image': await MultipartFile.fromFile(image.path),
    });

    await dio.post(CATEGORY_PATH, data: data);
    CustomSnackbar.showCustomToast(message: 'The category was added successfully');

    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    return false;
  }
}
