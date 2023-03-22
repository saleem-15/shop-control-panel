import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../shared/actions.dart';
import '../components/add_new_products_dialog.dart';
import '../services/delete_shipping_type_service.dart';
import '../services/get_all_shipping_type_service.dart';
import '../services/update_shipping_type_service.dart';

class ShippingController extends GetxController {
  RxBool isLoading = true.obs;
  late final List<PlutoColumn> columns;
  final List<PlutoRow> rows = [];

  bool isStateManagerInitialized = false;
  late PlutoGridStateManager stateManager;

  @override
  void onInit() {
    columns = [
      PlutoColumn(
        enableContextMenu: false,
        readOnly: true,
        width: 130,
        title: 'Id',
        field: 'shipping_type_id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 150,
        title: 'Shipping Name',
        field: 'title',
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
        title: 'Min Arrival Day',
        field: 'minNumberDaysToArrival',
        type: PlutoColumnType.number(
          negative: false,
        ),
      ),
      PlutoColumn(
        enableContextMenu: false,
        width: 100,
        title: 'Max Arrival Days',
        field: 'maxNumberDaysToArrival',
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
    final productId = row.cells['shipping_type_id']!.value.toString();
    final isDeleted = await deleteshippingTypeService(productId);

    if (isDeleted) {
      stateManager.removeRows([row]);
    }
  }

  void onFloatingActionButtonPressed() {
    Get.dialog(Center(child: AddNewShippingTypeDialog()));
  }

  Future<void> onCellValueChanged(PlutoGridOnChangedEvent event) async {
    final row = event.row!;
    final int columnIndex = event.columnIdx!;
    final PlutoCell cell = row.cells.values.elementAt(columnIndex);
    final String shippingTypeId = row.cells['shipping_type_id']!.value.toString();
    final dynamic newValue = event.value;
    final dynamic oldValue = event.oldValue;
    final String columnId = cell.column.field;

    final isUpdated = await updateShippingTypeService(shippingTypeId, columnId, newValue.toString());
    // log(cell.column.field.toString());

    /// if the new value is not updated on server => (write the old value to the table)
    if (!isUpdated) {
      stateManager.changeCellValue(cell, oldValue, callOnChangedEvent: false, force: true);
    }
  }

  Future<void> initShippingTypes() async {
    stateManager.setShowLoading(true);
    final productsRows = await getAllShippingTypesService();

    stateManager.appendRows(productsRows);
    isLoading(false);
    stateManager.setShowLoading(false);
  }

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;

    if (!isStateManagerInitialized) {
      initShippingTypes();
    }
    isStateManagerInitialized = true;
  }

  void refreshShippingTypes() {
    stateManager.removeAllRows();
    initShippingTypes();
  }
}
