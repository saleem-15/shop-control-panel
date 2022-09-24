import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/screens/orders/components/status.dart';

import 'services/get_orders.dart';

class OrdersController extends GetxController {
  final isLoading = true.obs;
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 130,
      title: 'Order Id',
      field: 'order_id',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 150,
      title: 'Product Name',
      field: 'product_name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 100,
      title: 'Address',
      field: 'address',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 150,
      title: 'Date',
      field: 'date',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 100,
      title: 'Price',
      field: 'price',
      type: PlutoColumnType.number(
        negative: false,
        //(Comma every three digits)  Thousand Dollars appears lik this => (1,000.00)
        format: '#,###.##',
        applyFormatOnInit: true,
      ),
    ),
    PlutoColumn(
      enableContextMenu: false,
      // readOnly: true,
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.select(
        <String>[
          'Complete',
          'Pending',
          'Canceled',
        ],
        enableColumnFilter: true,
      ),
      renderer: (rendererContext) => Status(status: rendererContext.cell.value.toString()),
    ),
  ];

  List<PlutoRow> rows = <PlutoRow>[];
  late PlutoGridStateManager stateManager;

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;
    initOrders();
  }

  Future<void> initOrders() async {
    stateManager.setShowLoading(true);
    final orders = await getOrders();
    stateManager.removeAllRows();
    stateManager.appendRows(orders);
    stateManager.setShowLoading(false);
    isLoading.value = false;
  }
}
