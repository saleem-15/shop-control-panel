import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../app_components/custom_snackbar.dart';
import '../../../constants/api_url.dart';

addNewCategoryService(File image, String name) async {
  // String fileName = image.path.split('/').last;

  // FormData formData = FormData.fromMap({
  //   "file": await MultipartFile.fromFile(image.path, filename: fileName),
  // });
  // response = await dio.post("/info", data: formData);
  // return response.data['id'];

  // String fileName = image.path.split('/').last;

  try {
    FormData data = FormData.fromMap({
      'name': name,
      'image': await MultipartFile.fromFile(image.path),
    });

    final response = await dio.post(addNewCategory, data: data);

    final categoriesData = response.data['Data'];
    CustomSnackbar.showCustomToast(message: 'The category was added successfully');

    log(response.toString());
    // final response = await dio.post(
    //   '/category/store',
    //   data: data,
    // );
  } on DioError catch (e) {
    log('add category');
    log(e.response.toString());
  }
}
