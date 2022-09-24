import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/screens/add_product/add_new_products_controller.dart';
import 'package:shop_conrol_panel/screens/products/services/get_all_products_service.dart';

import '../orders/components/actions.dart';
import 'services/delete_row.dart';
import 'services/update_product_service.dart';

class ProductsController extends GetxController {
  RxBool isLoading = true.obs;
  late final List<PlutoColumn> columns;
  final List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;
  PageController pageController = PageController();

  @override
  void onInit() {
    columns = [
      PlutoColumn(
        enableContextMenu: false,
        readOnly: true,
        width: 130,
        title: 'Product Id',
        field: 'product_id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 150,
        title: 'Product Name',
        field: 'product_name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 100,
        title: 'Price',
        field: 'price',
        type: PlutoColumnType.number(
          negative: false,
        ),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 120,
        title: 'Quantity',
        field: 'quantity',
        type: PlutoColumnType.number(
          negative: false,
        ),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 100,
        title: 'Colors',
        field: 'colors',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 150,
        title: 'Sizes',
        field: 'sizes',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 150,
        // frozen: PlutoColumnFrozen.end,

        enableColumnDrag: false,
        title: '',
        enableDropToResize: false,
        field: 'actions',
        type: PlutoColumnType.select(
          <String>['delete_button'],
          defaultValue: 'delete_button',
        ),
        renderer: (rendererContext) => DeleteButton(
          rendererContext: rendererContext,
          deleteRow: deleteRow,
        ),
      ),
    ];
    super.onInit();
  }

  Future<void> deleteRow(PlutoRow row) async {
    final productId = row.cells['product_id']!.value.toString();
    final isDeleted = await deleteProductService(productId);

    if (isDeleted) {
      stateManager.removeRows([row]);
    }
  }

  void goToAddNewProduct() {
    Get.find<AddNewProductsController>().goToProducts = goToProducts;
    pageController.animateToPage(
      1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void goToProducts() {
    pageController.animateToPage(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void onCellValueChanged(PlutoGridOnChangedEvent event) {
    final String productId = event.row!.cells['product_id']!.value.toString();
    final int columnIndex = event.columnIdx!;
    final newValue = event.value.toString();

    updatProductService(productId, columnIndex, newValue);
  }

  Future<void> initProducts() async {
    stateManager.setShowLoading(true);
    final productsRows = await getAllProductsService();
    stateManager.removeAllRows();
    stateManager.appendRows(productsRows);
    isLoading(false);
    stateManager.setShowLoading(false);
  }

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;
    initProducts();
  }
}
