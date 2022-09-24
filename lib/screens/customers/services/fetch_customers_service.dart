import 'package:pluto_grid/pluto_grid.dart';

Future<List<PlutoRow>> fetchCustomersService() async {
  await Future.delayed(const Duration(seconds: 3));
  return [
    PlutoRow(
      cells: {
        'customer_id': PlutoCell(value: 'user1'),
        'customer_name': PlutoCell(value: 'Mike'),
        'email': PlutoCell(value: 20),
        'Date_of_birth': PlutoCell(value: '2021-01-19'),
        'nick_name': PlutoCell(value: 'S/M/L/XL/XXL/XXXL'),
        'phone_number': PlutoCell(value: '09:00'),
      },
    ),
    PlutoRow(
      cells: {
        'customer_id': PlutoCell(value: 'user2'),
        'customer_name': PlutoCell(value: 'Jack'),
        'email': PlutoCell(value: 25),
        'Date_of_birth': PlutoCell(value: '2021-01-01'),
        'nick_name': PlutoCell(value: 'S/M/L/XL/XXL/'),
        'phone_number': PlutoCell(value: '10:00'),
      },
    ),
    PlutoRow(
      cells: {
        'customer_id': PlutoCell(value: 'user3'),
        'customer_name': PlutoCell(value: 'Suzi'),
        'email': PlutoCell(value: 40),
        'Date_of_birth': PlutoCell(value: '2021-01-01'),
        'nick_name': PlutoCell(value: 'M/L/XL/XXL/XXXL'),
        'phone_number': PlutoCell(value: '11:00'),
      },
    ),
  ];
}
