import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/helpers.dart';

import '../../../app_components/custom_snackbar.dart';
import '../../../constants/api.dart';
import '../../../storage/my_shared_pref.dart';

/// it returnes true if signup process is successful
Future<bool> signInService(String email, String password) async {
  try {
    final response = await dio.post(
      signIn,
      queryParameters: {
        'email': email,
        'password': password,
      },
    );
    //
    final data = response.data['Data'];
    log(data.toString());

    /// store the token in shared pref
    final token = data['access_token'].toString();
    MySharedPref.setUserToken(token);

    return true;
  } on DioError catch (e) {
    log(e.error.toString());
    CustomSnackbar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
  }

  return false;
}
