import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../utils/constants/api.dart';
import '../customers_controller.dart';

Future<List<PlutoRow>> fetchCustomersService(int pageNum, int numOfCustomersPerPage) async {
  try {
    final response = await dio.get(
      CUSTOMERS_PATH,
      queryParameters: {
        'page': pageNum,
        'paginate_num': numOfCustomersPerPage,
      },
    );

    final data = response.data['data'];
    final metaData = response.data['meta'];
    final numOfPages = metaData['last_page'] as int;
    final numOfAllCustomers = metaData['total'] as int;

    Get.find<CustomersController>().setAllCustomersNumber(numOfAllCustomers);
    Get.find<CustomersController>().setNumOfPages(numOfPages);

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
