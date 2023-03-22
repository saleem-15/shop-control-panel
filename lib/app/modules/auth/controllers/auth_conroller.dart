import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/utils/constants/api.dart';

import '../../../storage/my_shared_pref.dart';
import '../services/logout_service.dart';

class AuthController extends GetxController {
  bool isUserSignedIn = MySharedPref.getToken == null ? false : true;
  final pageController = PageController();

  void tokenListener(dynamic token) {
    if (token == null) {
      isUserSignedIn = false;
      update(['auth_listener']);
      changeAuthToken();
    } else {
      isUserSignedIn = true;
      update(['auth_listener']);
      changeAuthToken();
    }
  }

  @override
  void onInit() {
    // log('------------Auth controller is initilized-------------');
    // log('My token:${MySharedPref.getToken}');
    // log('is User logged in: $isUserSignedIn');

    MySharedPref.userTokenListener(tokenListener);
    super.onInit();
  }

  void logout() {
    Get.back();
    MySharedPref.setUserToken(null);
    isUserSignedIn = false;
    logoutService();
    update(['auth_listener']);
  }

  void goToLoginForm() {
    pageController.animateToPage(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void goToSignUpForm() {
    pageController.animateToPage(
      1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
