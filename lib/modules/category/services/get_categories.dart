import 'dart:developer';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/constants/api.dart';
import 'package:shop_conrol_panel/models/category.dart';

Future<dynamic> getCategoriesService() async {
  try {
    final response = await dio.get(CATEGORY_PATH);

    final categoriesData = response.data['Data'];

    return categoriesData;
  } catch (e) {
    log(e.toString());
  }
  return [];
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

List<Category> convertJsonToCategories(List<dynamic> categoriesData) {
  final categoriesList = <Category>[];

  for (var c in categoriesData) {
    final category = Category(
      id: c['id'],
      name: c['name'],
    );

    //add it to the list
    categoriesList.add(category);
  }

  return categoriesList;
}
