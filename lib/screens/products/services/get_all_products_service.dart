import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../constants/api_url.dart';

Future<List<PlutoRow>> getAllProductsService() async {
  try {
    final response = await dio.get(PRODUCT_PATH);
    final data = response.data['Data'];
    log(response.data.toString());

    return _convertDataToProductRows(data);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    return [];
  }
}

Future<List<PlutoRow>> _convertDataToProductRows(List data) async {
  final List<PlutoRow> productsList = [];

  for (Map<String, dynamic> product in data) {
    final row = PlutoRow(
      cells: {
        'product_id': PlutoCell(value: product['id']),
        'product_name': PlutoCell(value: product['name']),
        'price': PlutoCell(value: product['price']),
        //
        //! TODO make the back-end return (colors,sizes,quantity)
        'quantity': PlutoCell(value: product['1']),
        'sizes': PlutoCell(value: product['-']),
        'colors': PlutoCell(value: product['-']),
        'actions': PlutoCell(value: product['-']),
      },
    );
    productsList.add(row);
  }
  log('num of products:${productsList.length}');
  return productsList;
}
