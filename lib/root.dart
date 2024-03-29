import 'package:flutter/material.dart';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:get/get.dart';

import 'app/modules/category/category_screen.dart';
import 'app/modules/customers/customers_screen.dart';
import 'app/modules/orders/orders_screen.dart';
import 'app/modules/products/screens/products_screen.dart';
import 'app/modules/shipping/screens/shipping_screen.dart';
import 'config/theme/light_theme_colors.dart';

/// its outside the class so it does not re initilaze to 0 every time
final RxInt selectedIndex = 0.obs;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CollapsibleSidebar(
        items: items,
        title: 'Admin',
        titleBack: true,
        titleBackIcon: Icons.person, //the back icon is 'arrow_back' by default (customizable)
        body: Row(
          children: [
            Expanded(
              child: Obx(
                () {
                  selectedIndex.value;
                  return Builder(
                    builder: (context) {
                      switch (selectedIndex.value) {
                        case 0:
                          return OrdersScreen();
                        case 1:
                          return  ProductsScreen();

                        case 2:
                          return  CategoryScreen();

                        case 3:
                          return  CustomersScreen();

                        case 4:
                          return ShippingScreen();

                        default:
                          return  ProductsScreen();
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
    );
  }
}

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
  CollapsibleItem(
    onPressed: () => selectedIndex.value = 4,
    text: 'Shipping',
    icon: Icons.local_shipping_rounded,
    isSelected: selectedIndex.value == 4,
  ),
];
