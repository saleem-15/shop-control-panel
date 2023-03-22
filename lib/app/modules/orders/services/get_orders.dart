import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../utils/constants/api.dart';
import '../orders_controller.dart';

Future<List<PlutoRow>> getOrdersService(int pageNum, int numOfOrderPerPage) async {
  try {
    final response = await dio.get(
      ORDER_PATH,
      queryParameters: {
        'page': pageNum,
        'paginate_num': numOfOrderPerPage,
      },
    );

    final data = response.data['data'];
    final metaData = response.data['meta'];
    final numOfPages = metaData['last_page'] as int;
    final numOfAllOrders = metaData['total'] as int;

    Get.find<OrdersController>()
      ..setNumOfPages(numOfPages)
      ..setAllOrdersNumber(numOfAllOrders);

    // log(response.data.toString());
    return _convertDataToOrderRows(data);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    return [];
  }
}

Future<List<PlutoRow>> _convertDataToOrderRows(List data) async {
  final List<PlutoRow> ordersList = [];

  for (dynamic order in data) {
    final orderRow = PlutoRow(
      cells: {
        //order_id, product_id, products_name, color, size, address, shipping_type,
        //product_price, status, min_arrival_date, max_arrival_date
        'order_id': PlutoCell(value: order['order_id']),
        'product_name': PlutoCell(value: order['products_name']),
        'price': PlutoCell(value: double.parse(order['price'].toString())),
        // 1 => processing / 2 in delivery / 3 complete /4 admin refused
        'status': PlutoCell(
          value: order['status'] == 1
              ? 'Processing'
              : order['status'] == 2
                  ? 'Pending'
                  : order['status'] == 3
                      ? 'Complete'
                      : 'Canceled',
        ),
        'date': PlutoCell(value: order['date'] as String),
        'address': PlutoCell(value: order['address'] as String),
      },
    );

    ordersList.add(orderRow);
  }
  return ordersList;
}
