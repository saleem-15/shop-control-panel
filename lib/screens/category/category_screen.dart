import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'components/form.dart';
import 'categories_controller.dart';

class CategoryScreen extends GetView<CategoriesController> {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onFloatingActionButtonPressed,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        /// this line is added to fix a bug
        controller: ScrollController(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Existing Categories',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              // Obx(
              //   () => Wrap(
              //     runSpacing: 10,
              //     spacing: 10,
              //     children:
              //         controller.categories.map((categoryName) => Chip(label: Text(categoryName))).toList(),
              //   ),
              // ),

              SizedBox(
                width: 450,
                height: 500,
                child: PlutoGrid(
                  columns: controller.columns,
                  rows: controller.rows,
                  onLoaded: controller.onPlutoGridInit,
                  onChanged: controller.onCellValueChanged,
                  configuration: PlutoGridConfiguration(
                    enterKeyAction: PlutoGridEnterKeyAction.toggleEditing,
                    style: PlutoGridStyleConfig(
                      gridBorderRadius: BorderRadius.circular(10),
                      enableCellBorderVertical: false,
                      enableColumnBorderHorizontal: false,
                      enableColumnBorderVertical: false,
                      gridBorderColor: Colors.transparent,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              const CategoryInfoForm(),
            ],
          ),
        ),
      ),
    );
  }
}
