import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../categories_controller.dart';
import 'drop_image_area_widget.dart';

class CategoryInfoForm extends GetView<CategoriesController> {
  const CategoryInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SizedBox(
        width: 600,
        height: 400,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
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
                height: 20,
              ),
              ElevatedButton(
                onPressed: controller.addNewCategory,
                child: const Text('Add New Category'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
