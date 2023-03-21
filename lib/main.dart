import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shop_conrol_panel/root.dart';

import '../../app/modules/auth/controllers/auth_conroller.dart';
import '../../app/modules/auth/controllers/signin_controller.dart';
import 'app/modules/auth/screens/auth_screen.dart';
import '../../app/modules/category/categories_controller.dart';
import '../../app/modules/customers/customers_controller.dart';
import '../../app/modules/orders/orders_controller.dart';
import '../../app/modules/products/controllers/add_new_products_controller.dart';
import '../../app/modules/products/controllers/images_controller.dart';
import '../../app/modules/products/controllers/products_controller.dart';
import 'app/modules/auth/controllers/signup_controller.dart';
import 'app/modules/shipping/controllers/add_shipping_type_controller.dart';
import 'app/modules/shipping/controllers/shipping_controller.dart';
import 'app/storage/my_shared_pref.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  await MySharedPref.init();
  MySharedPref.setUserToken(null);
  initControllers();
  runApp(const Main());
}

void initControllers() {
  Get.lazyPut(() => ProductsController(), fenix: true);
  Get.lazyPut(() => AddNewProductsController(), fenix: true);
  Get.lazyPut(() => OrdersController(), fenix: true);
  Get.lazyPut(() => CategoriesController(), fenix: true);
  Get.lazyPut(() => CustomersController(), fenix: true);
  Get.lazyPut(() => ImagesController(), fenix: true);
  Get.lazyPut(() => ShippingController(), fenix: true);
  Get.lazyPut(() => AddNewShippingTypeController(), fenix: true);
  Get.put(AuthController(), permanent: true);
  Get.lazyPut(() => SigninController(), fenix: true);
  Get.lazyPut(() => SignupController(), fenix: true);
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
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
        debugShowCheckedModeBanner: false,
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
        title: 'Shop control panel',
        home: Container(
          color: Colors.blue,
          child: GetBuilder<AuthController>(
            assignId: true,
            id: 'auth_listener',
            builder: (controller) {
              return controller.isUserSignedIn ? const MyApp() : AuthScreen();
            },
          ),
        ),
      ),
    );
  }
}
