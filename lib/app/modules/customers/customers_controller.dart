import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../shared/pagination/pagination_controller.dart';
import 'services/fetch_customers_service.dart';

class CustomersController extends GetxController {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 130,
      title: 'Customer Id',
      field: 'customer_id',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 150,
      title: 'Customer Name',
      field: 'customer_name',
      type: PlutoColumnType.text(),
    ),
    // PlutoColumn(
    //   enableContextMenu: false,
    //   readOnly: true,
    //   width: 150,
    //   title: 'Nick Name',
    //   field: 'nick_name',
    //   type: PlutoColumnType.text(),
    // ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 200,
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      width: 150,
      readOnly: true,
      title: 'Date of birth',
      field: 'Date_of_birth',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 150,
      title: 'Phone Number',
      field: 'phone_number',
      type: PlutoColumnType.text(),
    ),
  ];

  final List<PlutoRow> rows = [];
  RxBool isStateManagerInitialized = false.obs;
  late PlutoGridStateManager stateManager;

  late final PaginationController paginationController;

  static const int pageSize = 3;

  /// this method should be called from the [PaginationController] only
  Future<void> fetchCustomers(int pageNum, int numOfCustomersPerPage) async {
    stateManager.setShowLoading(true);
    final rows = await fetchCustomersService(pageNum, numOfCustomersPerPage);
    stateManager.appendRows(rows);
    stateManager.setShowLoading(false);
  }

  void onPlutoGridInit(PlutoGridOnLoadedEvent event) {
    stateManager = event.stateManager;

    if (!isStateManagerInitialized.value) {
      paginationController = PaginationController(
        stateManager,
        pageSize,
        fetchCustomers,
      );
      isStateManagerInitialized.value = true;
    }
    paginationController.initStateManager(stateManager);
  }

  void setAllCustomersNumber(int numOfAllOrders) {
    paginationController.setAllItemsNumber(numOfAllOrders);
  }

  void setNumOfPages(int numOfPages) {
    paginationController.setNumOfPages(numOfPages);
  }

  /// reloads all the customers from the server again
  void refreshCustomers() {
    paginationController.refreshItems();
  }
}
