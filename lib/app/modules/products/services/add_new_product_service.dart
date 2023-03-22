import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

/// returnes true if the product is added successfully
Future<bool> addNewProductService(String categoryId, String name, double price, int quantity,
    String description, List<String> colors, List<String> sizes, List<File> images) async {
  FormData formData = FormData.fromMap({
    'name': name,
    'category_id': categoryId,
    'price': price,
    'quantity': quantity,
    'colors[]': colors,
    'sizes[]': sizes,
    'description': description,
  });

  for (var file in images) {
    formData.files.addAll([
      MapEntry("images[]", await MultipartFile.fromFile(file.path)),
    ]);
  }
  try {
    await dio.post(
      PRODUCT_PATH,
      data: formData,
    );
    //
    CustomSnackbar.showCustomToast(message: 'The product was added successfully!');
    // log(response.data.toString());
    return true;
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
