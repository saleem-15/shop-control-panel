import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'customers_controller.dart';

class CustomersScreen extends GetView<CustomersController> {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          onLoaded: controller.onPlutoGridInit,
          configuration: PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
              gridBorderRadius: BorderRadius.circular(10),
              enableCellBorderVertical: false,
              enableColumnBorderHorizontal: false,
              enableColumnBorderVertical: false,
              gridBorderColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
