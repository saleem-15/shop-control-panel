import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../utils/constants/table_config.dart';
import '../../shared/pagination/table_footer.dart';
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
        actions: [
          IconButton(
            onPressed: controller.refreshCustomers,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          onLoaded: controller.onPlutoGridInit,
          configuration: tableConfiguration,
          createFooter: (stateManager) {
            stateManager.setPageSize(CustomersController.pageSize,
                notify: false);
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
