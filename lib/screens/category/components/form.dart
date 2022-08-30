import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../categories_controller.dart';
import 'drop_image_area.dart';

class CategoryInfoForm extends GetView<CategoriesController> {
  const CategoryInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.nameController,
            validator: controller.nameValidator,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const DropImagesArea(),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: controller.addNewCategory,
            child: const Text('Add New Category'),
          )
        ],
      ),
    );
  }
}
