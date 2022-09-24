import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/config/theme/light_theme_colors.dart';
import 'package:shop_conrol_panel/screens/add_product/add_new_products_screen.dart';
import 'package:shop_conrol_panel/screens/products/products_controller.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Products(),
        AddNewProductScreen(),
      ],
    );
  }
}

class Products extends GetView<ProductsController> {
  const Products({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myBlack,
        foregroundColor: Colors.white,
        onPressed: controller.goToAddNewProduct,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          // columnGroups: controller.columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            controller.stateManager = event.stateManager;
          },
          onChanged: controller.onCellValueChanged,
          configuration: PlutoGridConfiguration(
            enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,
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
    );
  }
}
