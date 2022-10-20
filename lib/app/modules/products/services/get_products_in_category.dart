import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../utils/constants/api.dart';
import '../../../models/product.dart';

Future<void> getProductsInCategory(int categoryId) async {
  try {
    final response = await dio.post(
      '/product/index',
      queryParameters: {'category_id': categoryId},
    );
    log(response.data.toString());
  } on DioError catch (e) {
    log(e.response!.data.toString());
  }
}

List<PlutoRow> convertJsonToPlutoRows(List<dynamic> categoriesData) {
  final categoriesList = <PlutoRow>[];

  for (var category in categoriesData) {
    //create pluto cell
    final categoryRow = PlutoRow(
      cells: {
        'category_id': PlutoCell(value: category['id']),
        'category_name': PlutoCell(value: category['name']),
        'actions': PlutoCell(value: 'delete_button'),
      },
    );

    //add it to the list
    categoriesList.add(categoryRow);
  }

  return categoriesList;
}

List<Product> convertJsonToCategories(List<dynamic> productsData) {
  final categoriesList = <Product>[];

  for (var p in productsData) {
    final category = Product(
      isFavorite: false,
      sizes: [],
      colors: [],
      description: p['des'],
      id: p['id'],
      name: p['name'],
      price: p['price'],
      images: p[''],
    );

    //add it to the list
    categoriesList.add(category);
  }

  return categoriesList;
}
