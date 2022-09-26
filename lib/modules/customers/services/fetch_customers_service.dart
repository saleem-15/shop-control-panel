import 'package:pluto_grid/pluto_grid.dart';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api_url.dart';

Future<List<PlutoRow>> fetchCustomersService() async {

  try {
    final response = await dio.get(CUSTOMERS_PATH);
    final data = response.data['Data'];
    log(response.data.toString());

    return _convertDataToCustomerRows(data);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    return [];
  }
}

Future<List<PlutoRow>> _convertDataToCustomerRows(List data) async {
  final List<PlutoRow> customersList = [];

  //[, email, phone, nick_name, date_of_birth, image_url, address]
  for (Map<String, dynamic> customer in data) {
    final customerRow = PlutoRow(
      cells: {
        'customer_id': PlutoCell(value: customer['id']),
        'customer_name': PlutoCell(value: customer['name']),
        'email': PlutoCell(value: customer['email']),
        'Date_of_birth': PlutoCell(value: customer['date_of_birth']),
        // 'nick_name': PlutoCell(value: 'M/L/XL/XXL/XXXL'),
        'phone_number': PlutoCell(value: customer['phone']),
      },
    );
    customersList.add(customerRow);
  }
  log('num of customers:${customersList.length}');
  return customersList;
}
