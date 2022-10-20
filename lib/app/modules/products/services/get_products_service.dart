import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../utils/constants/api.dart';
import '../controllers/products_controller.dart';

Future<List<PlutoRow>> getProductsService(
    int pageNum, int numOfProductsPerPage) async {
  try {
    final response = await dio.get(
      PRODUCT_PATH,
      queryParameters: {
        'page': pageNum,
        'paginate_num': numOfProductsPerPage,
      },
    );

    final data = response.data['data'];
    final metaData = response.data['meta'];
    final numOfPages = metaData['last_page'] as int;
    final numOfAllProducts = metaData['total'] as int;

    Get.find<ProductsController>().setNumOfPages(numOfPages);
    Get.find<ProductsController>().setAllProductsNumber(numOfAllProducts);
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
        //! TODO make handle colors , sizes
        'quantity': PlutoCell(value: product['quantity']),
        'sizes': PlutoCell(value: product['sizes']),
        'colors': PlutoCell(value: product['colors']),
        'actions': PlutoCell(value: product['-']),
      },
    );
    productsList.add(row);
  }
  return productsList;
}
