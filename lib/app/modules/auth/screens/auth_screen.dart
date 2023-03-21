import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/app/modules/auth/controllers/auth_conroller.dart';
import 'package:shop_conrol_panel/utils/constants/assets.dart';

import '../components/login_form.dart';
import '../components/signup_form.dart';

class AuthScreen extends GetView<AuthController> {
  AuthScreen({super.key});
  final isShowPassword = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw, //screen width
          height: 1.sh, //screen height
          child: Row(
            children: [
              /// auth form (login or signup)
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    LogInForm(
                      isShowPassword: isShowPassword,
                    ),
                    SignUpForm(
                      isShowPassword: isShowPassword,
                    ),
                  ],
                ),
              ),

              /// svg picture
              Flexible(
                child: SvgPicture.asset(
                  Assets.LOGIN_ILLISTRUTION,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
