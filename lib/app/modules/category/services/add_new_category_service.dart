import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

///returnes true if the category was added successfully
Future<bool> addNewCategoryService(File image, String name) async {
  try {
    FormData data = FormData.fromMap({
      'name': name,
      'image': await MultipartFile.fromFile(image.path),
    });

    await dio.post(
      CATEGORY_PATH,
      data: data,
    );
    CustomSnackbar.showCustomToast(
      message: 'The category was added successfully',
    );

    return true;
  } on DioError catch (e) {
    log(e.toString());
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    return false;
  }
}
