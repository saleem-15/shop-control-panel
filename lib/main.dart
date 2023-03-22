import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shop_conrol_panel/root.dart';

import '../../app/modules/auth/controllers/auth_conroller.dart';
import 'app/modules/auth/screens/auth_screen.dart';
import 'app/storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  await MySharedPref.init();
  MySharedPref.setUserToken(null);
  runApp(const Main());
}

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) => GetMaterialApp(
        initialBinding: RootBinding(),
        debugShowCheckedModeBanner: false,
        smartManagement: SmartManagement.onlyBuilder,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
            PointerDeviceKind.trackpad,
          },
        ),
        builder: (context, widget) {
          return Theme(
            data: MyTheme.getThemeData(),
            child: MediaQuery(
              // but we want our app font to still the same and dont get affected
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            ),
          );
        },
        home: GetBuilder<AuthController>(
          assignId: true,
          id: 'auth_listener',
          builder: (controller) {
            return controller.isUserSignedIn ? const MyApp() : AuthScreen();
          },
        ),
      ),
    );
  }
}
