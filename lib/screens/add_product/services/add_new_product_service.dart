import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/custom_snackbar.dart';
import 'package:shop_conrol_panel/app_components/helpers.dart';

import '../../../constants/api_url.dart';

/// returnes true if the product is added successfully
Future<bool> addNewProductService(String categoryId, String name, double price, int quantity,
    String description, List<int> colors, List<String> sizes, List<File> images) async {
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
    final response = await dio.post(
      addNewProduct,
      data: formData,
    );
    //
    return true;
    CustomSnackbar.showCustomToast(message: 'The product was added successfully!');
    // log(response.data.toString());
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorToast(message: formatErrorMsg(e.response!.data));
    return false;
  }
}
