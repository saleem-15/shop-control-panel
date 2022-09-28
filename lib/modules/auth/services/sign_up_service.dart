import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_conrol_panel/app_components/custom_snackbar.dart';

import '../../../app_components/helpers.dart';
import '../../../constants/api.dart';
import '../../../storage/my_shared_pref.dart';

/// at the first index it returns the id of the user ,
/// ath the second index it returnes if signup process is successful
/// if signup process is Not successful then userId is Null
Future<List> signupService(String email, String password) async {
  String? userId;
  try {
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
      'name': 'Admin',
    });

    final response = await dio.post(
      signUp,
      data: formData,
    );
    log(response.data.toString());

    final responseData = response.data['Data'];

    /// store the token in shared pref
    final token = responseData['access_token'].toString();
    MySharedPref.setUserToken(token);

    userId = responseData['id'].toString();

    return [userId, true];
  } on DioError catch (e) {
    CustomSnackbar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
  }

  return [userId, false];
}
