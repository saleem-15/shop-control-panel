import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/theme/my_styles.dart';
import '../categories_controller.dart';
import 'drop_image_area_widget.dart';

class AddNewCategoryDialog extends GetView<CategoriesController> {
  const AddNewCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setDialogContext(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: Form(
          key: controller.formKey,
          child: SizedBox(
            width: 500,
            // height: 400,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    validator: controller.nameValidator,
                    decoration: MyStyles.getInputDecoration()
                        .copyWith(
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
                    onPressed: controller.onAddNewCategoryButtonPressed,
                    child: const Text('Add New Category'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
