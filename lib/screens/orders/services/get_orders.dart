import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../constants/api_url.dart';

Future<List<PlutoRow>> getOrders() async {
  try {
    final response = await dio.get(ORDER_PATH);
    final data = response.data['Data'];
    log(response.data.toString());

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
        'order_id': PlutoCell(value: order['order_id']),
        //
        //TODO the backend must returnes product_name with the order
        'product_name': PlutoCell(value: 'name'),
        'price': PlutoCell(value: double.parse(order['price'].toString())),
        //
        //! TODO you must make the bakend returnes on of the 3 states (Complete, Pending, Canceled)
        'status': PlutoCell(value: order['status'] == 'The order in processing' ? 'Pending' : 'Complete'),
        'date': PlutoCell(value: order['date'] as String),
        'address': PlutoCell(value: order['address']['address'] as String),
      },
    );

    ordersList.add(orderRow);
  }
  return ordersList;
}
