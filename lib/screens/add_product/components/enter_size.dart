import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_new_products_controller.dart';

class EnterSize extends GetView<AddNewProductsController> {
  const EnterSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 230,
              child: TextFormField(
                controller: controller.sizeController,
                decoration: const InputDecoration(
                  hintText: 'Enter Size',
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: controller.addNewSize,
                child: const Text('Add New Size'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Wrap(
            runSpacing: 10,
            children: controller.sizes
                .map(
                  (size) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                      color: Colors.grey[200],
                    ),
                    child: FittedBox(
                      child: Text(
                        size,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
