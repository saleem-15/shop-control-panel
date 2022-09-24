import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pluto_grid/pluto_grid.dart';

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
    PlutoColumn(
      enableContextMenu: false,
      readOnly: true,
      width: 150,
      title: 'Nick Name',
      field: 'nick_name',
      type: PlutoColumnType.text(),
    ),
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
      type: PlutoColumnType.date(),
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

  late PlutoGridStateManager stateManager;

  @override
  Future<void> onReady() async {
    final List<PlutoRow> customers = await fetchCustomersService();

    stateManager.appendRows(customers);
    stateManager.setShowLoading(false);

    super.onReady();
  }

  Future<void> onPlutoGridInit(PlutoGridOnLoadedEvent event) async {
    stateManager = event.stateManager;
    event.stateManager.setShowLoading(true);
    final rows = await fetchCustomersService();
    stateManager.appendRows(rows);
    event.stateManager.setShowLoading(false);
  }
}
