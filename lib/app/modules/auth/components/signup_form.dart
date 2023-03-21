
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shop_conrol_panel/config/theme/my_styles.dart';
import 'package:shop_conrol_panel/utils/constants/assets.dart';

import '../controllers/signup_controller.dart';


class SignUpForm extends GetView<SignupController> {
  const SignUpForm({
    super.key,
    required this.isShowPassword,
  });

  final RxBool isShowPassword;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: MyStyles.getInputDecorationTheme(),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Theme.of(context).iconTheme.color,
            ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xffa9a5c6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Title
            Text(
              'Craete Your \nAdmin Account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            SizedBox(
              height: 40.sp,
            ),
            Center(
              child: Form(
                key: controller.formKey,
                // the textField is wrapped in (theme) so when the textField has Focus the icon color
                //(in the textField) change to my specific color
                child: SizedBox(
                  width: 120.sp,
                  child: Column(
                    children: [
                      ///Email TextField
                      TextFormField(
                        controller: controller.emailController,
                        validator: controller.emailFieldValidator,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Container(
                            width: 60,
                            padding: EdgeInsets.only(left: 5.sp),
                            child: const Icon(Icons.email_rounded),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      ///Password TextField
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          validator: controller.passwordFieldValidator,
                          obscureText: isShowPassword.isTrue,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Container(
                              width: 60,
                              padding: EdgeInsets.only(left: 5.sp),
                              child: const ImageIcon(
                                AssetImage(Assets.IC_LOCK),
                              ),
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () => isShowPassword.toggle(),
                              icon: ImageIcon(
                                AssetImage(
                                  isShowPassword.isTrue ? Assets.IC_SHOW : Assets.IC_HIDE,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      /// Sign Up Button
                      ElevatedButton(
                        onPressed: controller.onSignupButtonPressed,
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 50.h,
            ),

            /// Already Have an account (text)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?  ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
                GestureDetector(
                  onTap: controller.goToSignin,
                  child: Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
