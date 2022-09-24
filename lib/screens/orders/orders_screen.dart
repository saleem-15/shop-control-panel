import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'orders_controller.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // width: 500,
        // height: 500,
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          // columnGroups: controller.columnGroups,
          onLoaded: controller.onPlutoGridInit,
          onChanged: (PlutoGridOnChangedEvent event) {
            log(event.toString());
          },
          configuration: PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
              gridBorderRadius: BorderRadius.circular(10),
              gridPopupBorderRadius: BorderRadius.circular(10),
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
