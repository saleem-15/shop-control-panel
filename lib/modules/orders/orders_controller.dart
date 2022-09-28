import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/app_components/pagination/pagination_controller.dart';
import 'package:shop_conrol_panel/modules/orders/components/status.dart';

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
          'Processing',
          'Pending',
          'Complete',
          'Canceled',
        ],
        enableColumnFilter: true,
      ),
      renderer: (rendererContext) => Status(status: rendererContext.cell.value.toString()),
    ),
  ];
  List<PlutoRow> rows = <PlutoRow>[];

  RxBool isStateManagerInitialized = false.obs;
  late PlutoGridStateManager stateManager;

  /// this determines the number of orders per page
  static const int pageSize = 3;

  late final PaginationController paginationController;

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;

    if (!isStateManagerInitialized.value) {
      paginationController = PaginationController(
        stateManager,
        pageSize,
        fetchOrders,
      );
      isStateManagerInitialized.value = true;
    }
    paginationController.initStateManager(stateManager);
  }

  /// this method should be called by the pagination controller only
  Future<void> fetchOrders(int pageNum, int numOfItemsPerPage) async {
    stateManager.setShowLoading(true);
    final orders = await getOrdersService(pageNum, numOfItemsPerPage);
    stateManager.appendRows(orders);
    stateManager.setShowLoading(false);
    isLoading.value = false;
  }

  void setAllOrdersNumber(int numOfAllOrders) {
    paginationController.setAllItemsNumber(numOfAllOrders);
  }

  void setNumOfPages(int numOfPages) {
    paginationController.setNumOfPages(numOfPages);
  }

  /// reloads all the products from the server again
  void refreshOrders() {
    paginationController.refreshItems();
  }
}
