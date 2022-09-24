import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/config/theme/light_theme_colors.dart';
import 'package:shop_conrol_panel/screens/customers/customers_screen.dart';
import 'package:shop_conrol_panel/screens/orders/orders_screen.dart';

import 'config/theme/my_theme.dart';
import 'screens/add_product/add_new_products_controller.dart';
import 'screens/add_product/images_controller.dart';
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
  Get.lazyPut(() => AddNewProductsController(), fenix: true);
  Get.lazyPut(() => OrdersController(), fenix: true);
  Get.lazyPut(() => CategoriesController(), fenix: true);
  Get.lazyPut(() => CustomersController(), fenix: true);
  Get.lazyPut(() => ImagesController(), fenix: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<CollapsibleItem> items = [
      CollapsibleItem(
        onPressed: () => selectedIndex.value = 0,
        text: 'Orders',
        icon: Icons.shopping_cart,
        isSelected: selectedIndex.value == 0,
      ),
      CollapsibleItem(
        onPressed: () => selectedIndex.value = 1,
        text: 'Products',
        icon: Icons.add_box,
        isSelected: selectedIndex.value == 1,
      ),
      CollapsibleItem(
        onPressed: () => selectedIndex.value = 2,
        text: 'Categories',
        icon: Icons.category,
        isSelected: selectedIndex.value == 2,
      ),
      CollapsibleItem(
        onPressed: () => selectedIndex.value = 3,
        text: 'Customers',
        icon: Icons.people,
        isSelected: selectedIndex.value == 3,
      ),
    ];

    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        smartManagement: SmartManagement.onlyBuilder,
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
          body: CollapsibleSidebar(
            items: items,
            title: 'Admin',

            titleBack: true,
            titleBackIcon: Icons.person, //the back icon is 'arrow_back' by default (customizable)

            body: Row(
              children: [
                // Menu(index: selectedIndex),
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

            sidebarBoxShadow: const [
              BoxShadow(color: myBlack, blurRadius: 10, spreadRadius: 0.01, offset: Offset(3, 3))
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