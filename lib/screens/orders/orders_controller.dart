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
  
  RxList<PlutoRow> rows = <PlutoRow>[].obs;
  late PlutoGridStateManager stateManager;
  List x = [];
  @override
  Future<void> onReady() async {
    final list = await getOrders();
    rows.addAll(list);
    isLoading.value = false;
    super.onInit();
  }
}

/*
  PlutoRow(
      cells: {
        'order_id': PlutoCell(value: 'user1'),
        'product_name': PlutoCell(value: 'Mike'),
        'price': PlutoCell(value: 20),
        'status': PlutoCell(value: 'Pending'),
        'date': PlutoCell(value: '2021-01-01'),
        'address': PlutoCell(value: '09:00'),
      },
    ),
    PlutoRow(
      cells: {
        'order_id': PlutoCell(value: 'user2'),
        'product_name': PlutoCell(value: 'Jack'),
        'price': PlutoCell(value: 25),
        'status': PlutoCell(value: 'Canceled'),
        'date': PlutoCell(value: '2021-02-01'),
        'address': PlutoCell(value: '10:00'),
      },
    ),
    PlutoRow(
      cells: {
        'order_id': PlutoCell(value: 'user3'),
        'product_name': PlutoCell(value: 'Suzi'),
        'price': PlutoCell(value: 40),
        'status': PlutoCell(value: 'Complete'),
        'date': PlutoCell(value: '2021-03-01'),
        'address': PlutoCell(value: '11:00'),
      },
    ),
*/
