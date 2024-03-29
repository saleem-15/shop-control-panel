import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../config/theme/light_theme_colors.dart';
import '../../../utils/constants/table_config.dart';
import 'categories_controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key})
      : controller = Get.put(
          CategoriesController(),
          permanent: true,
        );

  late final CategoriesController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: controller.refreshCategories,
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightThemeColors.floatingActionButtonColor,
        onPressed: controller.onFABPressed,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        /// this line is added to fix a bug
        controller: ScrollController(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            width: 450,
            height: 500,
            child: PlutoGrid(
              columns: controller.columns,
              rows: controller.rows,
              onLoaded: controller.onPlutoGridInit,
              onChanged: controller.onCellValueChanged,
              configuration: tableConfiguration,
            ),
          ),
        ),
      ),
    );
  }
}
