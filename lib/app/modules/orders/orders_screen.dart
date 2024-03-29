import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../utils/constants/table_config.dart';
import '../../shared/pagination/table_footer.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key}) : controller = Get.put(OrdersController());

  late final OrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: controller.refreshOrders,
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          onLoaded: controller.onPlutoGridInit,
          configuration: tableConfiguration,
          createFooter: (stateManager) {
            return Obx(
              () => controller.isStateManagerInitialized.isTrue
                  ? TableFooter(
                      paginationController: controller.paginationController,
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
