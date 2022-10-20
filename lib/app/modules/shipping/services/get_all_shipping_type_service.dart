import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../utils/constants/api.dart';

Future<List<PlutoRow>> getAllShippingTypesService() async {
  try {
    final response = await dio.get(SHIPPING_TYPE_PATH);
    final data = response.data['Data'];
    // log(data.toString());

    return _convertDataToShippingTypeRows(data);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    return [];
  }
}

Future<List<PlutoRow>> _convertDataToShippingTypeRows(List data) async {
  final List<PlutoRow> shippingTypesList = [];

  for (Map<String, dynamic> product in data) {
    final row = PlutoRow(
      cells: {
        'shipping_type_id': PlutoCell(value: product['shippingType_id']),
        'title': PlutoCell(value: product['title']),
        'price': PlutoCell(value: product['price']),
        'minNumberDaysToArrival': PlutoCell(value: product['min_arrival_days']),
        'maxNumberDaysToArrival': PlutoCell(value: product['max_arrival_days']),
        'actions': PlutoCell(value: 'delete_button'),
      },
    );
    shippingTypesList.add(row);
  }
  return shippingTypesList;
}
