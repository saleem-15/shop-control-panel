import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/constants/api_url.dart';

Future<void> deleteRowService(String productId) async {
  try {
    final response = await dio.post(
      '/product/destroy',
      queryParameters: {'product_id': productId},
    );

    log(response.data);
  } on DioError catch (e) {
    log(e.message);
  }
}
