import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_new_products_controller.dart';

class EnterColors extends GetView<AddNewProductsController> {
  const EnterColors({Key? key}) : super(key: key);

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
                controller: controller.colorController,
                decoration: const InputDecoration(
                  hintText: 'Hex Color Value ',
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: controller.addNewColor,
                child: const Text('Add New Color'),
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
            children: [
              ...List.generate(
                controller.colors.length,
                (index) {
                  //
                  return SizedBox(
                    width: 50,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.red,
                        color: Color(int.parse('0xff${controller.colors[index]}')),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
