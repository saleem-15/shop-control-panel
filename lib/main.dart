import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/screens/customers/customers_screen.dart';
import 'package:shop_conrol_panel/screens/orders/orders_screen.dart';

import 'components/menu.dart';
import 'config/theme/my_theme.dart';
import 'screens/category/categories_controller.dart';
import 'screens/category/category_screen.dart';
import 'screens/customers/customers_controller.dart';
import 'screens/orders/orders_controller.dart';
import 'screens/products/products_controller.dart';
import 'screens/products/products_screen.dart';
import 'storage/my_shared_pref.dart';

Future<void> main() async {
  await MySharedPref.init();
  Get.lazyPut(() => ProductsController(), fenix: true);
  Get.lazyPut(() => OrdersController(), fenix: true);
  Get.lazyPut(() => CategoriesController(), fenix: true);
  Get.lazyPut(() => CustomersController(), fenix: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          bool themeIsLight = MySharedPref.getThemeIsLight();
          return Theme(
            data: MyTheme.getThemeData(isLight: themeIsLight),
            child: MediaQuery(
              // but we want our app font to still the same and dont get affected
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            ),
          );
        },
        title: 'Material App',
        home: Scaffold(
          body: Row(
            children: [
              Menu(index: selectedIndex),
              Expanded(
                child: Obx(
                  () {
                    selectedIndex.value;
                    return Builder(
                      builder: (context) {
                        switch (selectedIndex.value) {
                          case 0:
                            return  OrdersScreen();
                          case 1:
                            return const ProductsScreen();
                          case 2:
                            return const CategoryScreen();

                          case 3:
                            return const CustomersScreen();
                          default:
                            return const ProductsScreen();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*

 Row(
            children: [
              Menu(index: index),
              Expanded(
                child: Obx(
                  () {
                    index.value;
                    return Builder(
                      builder: (context) {
                        switch (index.value) {
                          case 0:
                            return const OrdersScreen();
                          case 1:
                            return const ProductsScreen();
                          default:
                            return const ProductsScreen();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
*/


/*

Row(
            children: [

              Obx(
                () => SideNavigationBar(
                  theme: SideNavigationBarTheme(
                    itemTheme: SideNavigationBarItemTheme.standard(),
                    togglerTheme: SideNavigationBarTogglerTheme.standard(),
                    dividerTheme: SideNavigationBarDividerTheme.standard(),
                    backgroundColor: Colors.white,
                  ),
                  selectedIndex: selectedIndex.value,
                  items: const [
                    SideNavigationBarItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                    ),
                    SideNavigationBarItem(
                      icon: Icons.person,
                      label: 'Account',
                    ),
                    SideNavigationBarItem(
                      icon: IconData(1024),
                      label: 'Settings',
                    ),
                  ],
                  onTap: (index) {
                    selectedIndex.value = index;
                  },
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    selectedIndex.value;
                    return Builder(
                      builder: (context) {
                        switch (selectedIndex.value) {
                          case 0:
                            return const OrdersScreen();
                          case 1:
                            return const ProductsScreen();
                          default:
                            return const ProductsScreen();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
*/



/*CollapsibleSidebar(
            // isCollapsed: MediaQuery.of(context).size.width <= 600,
            title: ' ',
            titleBack: true,
            titleBackIcon: Icons.,
            onHoverPointer: SystemMouseCursors.disappearing,
            items: [
              CollapsibleItem(
                text: 'Orders',
                icon: Icons.shopping_cart,
                onPressed: () => index(0),
                isSelected: true,
              ),
              CollapsibleItem(
                text: 'Products',
                icon: Icons.shopping_cart,
                onPressed: () => index(1),
              ),
            ],
            // avatarImg: _avatarImg,
            // title: 'John Smith',
            body: Obx(
              () {
                index.value;
                return Builder(
                  builder: (context) {
                    switch (index.value) {
                      case 0:
                        return const OrdersScreen();
                      case 1:
                        return const ProductsScreen();
                      default:
                        return const ProductsScreen();
                    }
                  },
                );
              },
            ),
          ),
          */