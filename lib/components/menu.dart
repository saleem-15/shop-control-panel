// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shop_conrol_panel/config/theme/light_theme_colors.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
    required this.index,
  }) : super(key: key);

  final RxInt index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myBlack,
      height: double.infinity,
      width: 200,
      child: Obx(
        () => Column(
          children: [
            ListTile(
              onTap: () => index.value = 0,
              leading: Icon(
                Icons.shopping_cart,
                color: index.value == 0 ? Colors.white : ThemeData.light().iconTheme.color,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                  color: index.value == 0 ? Colors.white : ThemeData.light().iconTheme.color,
                ),
              ),
            ),
            ListTile(
              onTap: () => index.value = 1,
              leading: Icon(
                Icons.add_box,
                color: index.value == 1 ? Colors.white : ThemeData.light().iconTheme.color,
              ),
              title: Text(
                'Products',
                style: TextStyle(
                  color: index.value == 1 ? Colors.white : ThemeData.light().iconTheme.color,
                ),
              ),
            ),
            ListTile(
              onTap: () => index.value = 2,
              leading: Icon(
                Icons.category,
                color: index.value == 2 ? Colors.white : ThemeData.light().iconTheme.color,
              ),
              title: Text(
                'Categories',
                style: TextStyle(
                  color: index.value == 2 ? Colors.white : ThemeData.light().iconTheme.color,
                ),
              ),
            ),
            ListTile(
              onTap: () => index.value = 3,
              leading: Icon(
                Icons.people,
                color: index.value == 3 ? Colors.white : ThemeData.light().iconTheme.color,
              ),
              title: Text(
                'Customers',
                style: TextStyle(
                  color: index.value == 3 ? Colors.white : ThemeData.light().iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
