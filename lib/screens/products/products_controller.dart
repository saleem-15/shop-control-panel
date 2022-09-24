import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/screens/add_product/add_new_products_controller.dart';

import '../orders/components/actions.dart';
import 'services/delete_row.dart';
import 'services/update_row.dart';

class ProductsController extends GetxController {
  final List<PlutoColumn> columns = <PlutoColumn>[
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
      renderer: (rendererContext) => DeleteButton(rendererContext: rendererContext),
    ),
  ];

  void deleteRow(PlutoRow row) {
    stateManager.removeRows([row]);
    final productId = row.cells['product_id']!.value;
    deleteRowService(productId);
  }

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'product_id': PlutoCell(value: 'user1'),
        'product_name': PlutoCell(value: 'Mike'),
        'price': PlutoCell(value: 20),
        'quantity': PlutoCell(value: 'Pending'),
        'sizes': PlutoCell(value: 'S/M/L/XL/XXL/XXXL'),
        'colors': PlutoCell(value: 'grey/green/black'),
        'actions': PlutoCell(value: 'delete_button'),
      },
    ),
    PlutoRow(
      cells: {
        'product_id': PlutoCell(value: 'user2'),
        'product_name': PlutoCell(value: 'Jack'),
        'price': PlutoCell(value: 25),
        'quantity': PlutoCell(value: 'Canceled'),
        'sizes': PlutoCell(value: 'S/M/L/XL/XXL/'),
        'colors': PlutoCell(value: 'white/black'),
        'actions': PlutoCell(value: 'delete_button'),
      },
    ),
    PlutoRow(
      cells: {
        'product_id': PlutoCell(value: 'user3'),
        'product_name': PlutoCell(value: 'Suzi'),
        'price': PlutoCell(value: 40),
        'quantity': PlutoCell(value: 'Complete'),
        'sizes': PlutoCell(value: 'M/L/XL/XXL/XXXL'),
        'colors': PlutoCell(value: 'red/blue'),
        'actions': PlutoCell(value: 'delete_button'),
      },
    ),
  ];

  late PlutoGridStateManager stateManager;

  PageController pageController = PageController();

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
    final String productId = event.row!.cells['product_id']!.value;
    final int columnIndex = event.columnIdx!;
    final newValue = event.value;

    updateRowInfo(productId, columnIndex, newValue);
  }
}
