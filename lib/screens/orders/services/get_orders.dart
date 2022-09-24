import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../constants/api_url.dart';

Future<List<PlutoRow>> getOrders() async {
  try {
    final response = await dio.get(getAllOrders);
    final data = response.data['Data'];
    // log(response.data.toString());

    return _convertDataToOrderRows(data);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    return [];
  }
}

Future<List<PlutoRow>> _convertDataToOrderRows(data) async {
  final List<PlutoRow> list = [];
  return list;
  // Map<String, dynamic>
  String json =
      '{"orders":[{"product_id":"1","product_name":"Mike","price":"20","status":"Pending","date":"2021-01-01","address":"09:00"},{"product_id":"2","product_name":"Ali","price":"49.99","status":"Pending","date":"2021-01-01","address":"09:00"}]}';

/*
 "order_id": 1,
        "product_id": "3",
        "products_name": "laptop2",
        "color": "123456",
        "image_url": "public/img/products/1663940871937.png",
        "address": {
            "id": 1,
            "user_id": 1,
            "title": "home",
            "address": "teafdsbkjfdk",
            "default": 1
        },
        "shipping_type": "slow",
        "product_price": 123,
        "quantity": "1",
        "status": "The order in processing",
        "min_arrival_date": "11/10/2022",
        "max_arrival_date": "17/10/2022"
    },

// */
//   final map = jsonDecode(json) as Map<String, dynamic>;

//   final ordersList = map['orders'] as List;

//   for (Map<String, dynamic> order in ordersList) {
//     list.add(
//       PlutoRow(
//         cells: {
//           'product_id': PlutoCell(value: order['product_id'] as String),
//           'product_name': PlutoCell(value: order['product_name'] as String),
//           'price': PlutoCell(value: double.parse(order['price'] as String)),
//           'status': PlutoCell(value: order['status'] as String),
//           'date': PlutoCell(value: order['date'] as String),
//           'address': PlutoCell(value: order['address'] as String),
//         },
//       ),
//     );
//   }
//   // for (var element in list) {
//   //   element.cells.forEach((key, value) {
//   //     log('$key: ${value.value}');
//   //   });
//   // }

//   // await Future.delayed(const Duration(seconds: 3));
//   // return list;

//   // return [
//     PlutoRow(
//       cells: {
//         'order_id': PlutoCell(value: 'user1'),
//         'product_name': PlutoCell(value: 'Mike'),
//         'price': PlutoCell(value: 20),
//         'status': PlutoCell(value: 'Pending'),
//         'date': PlutoCell(value: '2021-01-01'),
//         'address': PlutoCell(value: '09:00'),
//       },
//     ),
//     PlutoRow(
//       cells: {
//         'order_id': PlutoCell(value: 'user2'),
//         'product_name': PlutoCell(value: 'Jack'),
//         'price': PlutoCell(value: 25),
//         'status': PlutoCell(value: 'Canceled'),
//         'date': PlutoCell(value: '2021-02-01'),
//         'address': PlutoCell(value: '10:00'),
//       },
//     ),
//     PlutoRow(
//       cells: {
//         'order_id': PlutoCell(value: 'user3'),
//         'product_name': PlutoCell(value: 'Suzi'),
//         'price': PlutoCell(value: '49.99'),
//         'status': PlutoCell(value: 'Complete'),
//         'date': PlutoCell(value: '2021-03-01'),
//         'address': PlutoCell(value: '11:00'),
//       },
//     ),
//   ];
}
