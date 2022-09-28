import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/custom_snackbar.dart';

import '../../../constants/api.dart';

Future<void> logoutService() async {
  try {
    final response = await dio.post(logout);
    log(response.data.toString());
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorSnackBar(
      title: 'Error',
      message: e.response!.data['Messages'].toString(),
    );
  }
}
