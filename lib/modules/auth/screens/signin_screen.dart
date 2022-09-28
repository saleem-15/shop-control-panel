// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/config/theme/my_styles.dart';

import '../controllers/signin_controller.dart';

class SigninScreen extends GetView<SigninController> {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isShowPassword = false.obs;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 15.w,
            left: 15.w,
            top: 15.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login To Your ',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'Admin Account',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 40.sp,
              ),
              Form(
                key: controller.formKey,
                // the textField is wrapped in (theme) so when the textField has Focus the icon color
                //(in the textField) change to my specific color
                child: Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: MyStyles.getInputDecorationTheme(isLightTheme: true),
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Theme.of(context).iconTheme.color,
                        ),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        validator: controller.emailFieldValidator,
                        textInputAction: TextInputAction.next, // Moves focus to next field

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
                        height: 15.h,
                      ),
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
                              child: const ImageIcon(AssetImage('assets/lock_icon_32.png')),
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () => isShowPassword.toggle(),
                              icon: ImageIcon(
                                AssetImage(
                                  isShowPassword.isTrue
                                      ? 'assets/show_icon_32.png'
                                      : 'assets/hide_icon_32.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ElevatedButton(
                onPressed: controller.signIn,
                child: const Text('Sign in'),
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?  ',
                    style:
                        Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).hintColor),
                  ),
                  GestureDetector(
                    onTap: controller.goToSignup,
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
