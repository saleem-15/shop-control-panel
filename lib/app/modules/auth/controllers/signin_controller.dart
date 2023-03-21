import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shop_conrol_panel/app/modules/auth/controllers/auth_conroller.dart';

import '../../../../main.dart';
import '../components/signup_form.dart';
import '../services/sign_in_service.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final isSuccessfull = await signInService(email, password);

    if (isSuccessfull) {
      Get.off(() => const Main());
    }
  }

  String? emailFieldValidator(String? value) {
    if (emailController.text.isEmail) {
      return null;
    }

    return 'Enter a valid email';
  }

  String? passwordFieldValidator(String? value) {
    if (passwordController.text.length.isLowerThan(6)) {
      return 'Wrong password';
    }
    return null;
  }

  void goToSignup() {
    Get.find<AuthController>().goToSignUpForm();
  }

  void forgetPassword() {}

  void signinWithGoogle() {}

  void signinWithFacebook() {}
}
