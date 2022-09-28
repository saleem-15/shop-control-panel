import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:shop_conrol_panel/config/theme/light_theme_colors.dart';
import 'package:shop_conrol_panel/modules/products/controllers/products_controller.dart';

import '../../../app_components/pagination/table_footer.dart';
import '../../../constants/constants.dart';
import 'add_new_products_screen.dart';

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
        actions: [
          IconButton(
            onPressed: controller.refreshProducts,
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
        foregroundColor: Colors.white,
        onPressed: controller.goToAddNewProduct,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          onLoaded: controller.onPlutoGridInit,
          onChanged: controller.onCellValueChanged,
          configuration: tableConfiguration,
          createFooter: (stateManager) {
            stateManager.setPageSize(ProductsController.pageSize);

            return Obx(
              () => controller.isStateManagerInitialized.isTrue
                  ? TableFooter(
                      paginationController: controller.paginationController,
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
