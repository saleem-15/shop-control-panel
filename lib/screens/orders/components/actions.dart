import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shop_conrol_panel/screens/category/categories_controller.dart';

import 'package:shop_conrol_panel/screens/products/products_controller.dart';

class DeleteButton extends GetView<CategoriesController> {
  const DeleteButton({
    Key? key,
    required this.rendererContext,
  }) : super(key: key);

  final PlutoColumnRendererContext rendererContext;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        log('Hi');
        controller.deleteRow(rendererContext.row);
        
      },
      icon: const Icon(Icons.delete),
    );
  }
}
