import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../screens/signin_screen.dart';
import '../services/sign_up_service.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  final formKey = GlobalKey<FormState>();

  Future<void> onSignupButtonPressed() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    await signup();
  }

  Future<void> signup() async {
    final results = await signupService(
      email,
      password,
    );

    /// is sign up process is done correctly
    final isSuccessfull = results[1];

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
      return 'min password lenght is 6 characters';
    }
    return null;
  }

  void goToSignin() {
    Get.to(() => const SigninScreen());
  }
}
