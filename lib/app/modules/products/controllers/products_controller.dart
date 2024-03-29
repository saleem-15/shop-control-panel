import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../modules/products/services/get_products_service.dart';
import '../../../shared/actions.dart';
import '../../../shared/pagination/pagination_controller.dart';
import '../services/delete_row.dart';
import '../services/update_product_service.dart';
import 'add_new_products_controller.dart';

class ProductsController extends GetxController {
  late final List<PlutoColumn> columns;
  final List<PlutoRow> rows = [];

  RxBool isStateManagerInitialized = false.obs;
  static late PlutoGridStateManager stateManager;
  PageController pageController = PageController();

  late final PaginationController paginationController;

  static const int pageSize = 10;

  @override
  void onInit() {
    ///initializing table columns
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

  Future<List<PlutoRow>> fetchProducts(int pageNum, int numOfItemsPerPage) async {
    return getProductsService(pageNum, numOfItemsPerPage);
  }

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;

    if (!isStateManagerInitialized.value) {
      paginationController = PaginationController(
        stateManager,
        pageSize,
        fetchProducts,
      );
      isStateManagerInitialized.value = true;
    }
    paginationController.initStateManager(stateManager);
  }

  /// reloads all the products from the server again
  void refreshProducts() {
    paginationController.refreshItems();
  }

  void setAllProductsNumber(int numOfAllProducts) {
    paginationController.setAllItemsNumber(numOfAllProducts);
  }

  void setNumOfPages(int numOfPages) {
    paginationController.setNumOfPages(numOfPages);
  }
}
