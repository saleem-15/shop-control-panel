import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../utils/constants/table_config.dart';
import '../controllers/shipping_controller.dart';
import '/config/theme/light_theme_colors.dart';

class ShippingScreen extends StatelessWidget {
  ShippingScreen({super.key}) : controller = Get.put(ShippingController());

  late final ShippingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: controller.refreshShippingTypes,
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightThemeColors.floatingActionButtonColor,
        foregroundColor: Colors.white,
        onPressed: controller.onFloatingActionButtonPressed,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: controller.columns,
          rows: controller.rows,
          onLoaded: controller.onPlutoGridInit,
          onChanged: controller.onCellValueChanged,
          configuration: tableConfiguration,
        ),
      ),
    );
  }
}
