import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shop_conrol_panel/constants/api_url.dart';

Future<void> updateCategoryInfo(int categoryId, String newValue) async {
  final uri = Uri.http(apiUrl, '$apiPath/category/update', {
    'Api_Password': apikey,
    'category_id': '$categoryId',
    'name': newValue,
  });

  final responese = await http.post(uri);
  final json = jsonDecode(responese.body);

  log(json.toString());
  log('new VALUE: $newValue');
}
