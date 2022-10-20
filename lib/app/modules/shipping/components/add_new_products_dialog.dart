import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shop_conrol_panel/config/theme/my_styles.dart';

import '../controllers/add_shipping_type_controller.dart';

class AddNewShippingTypeDialog extends GetView<AddNewShippingTypeController> {
  const AddNewShippingTypeDialog({Key? key}) : super(key: key);

  static const spaceBetweenFields = 30.0;

  @override
  Widget build(BuildContext context) {
    /// used to pop the dialog
    controller.setDialogContext(context);
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: MyStyles.getInputDecorationTheme(),
        ),
        child: SingleChildScrollView(
          //this is added to fix a bug
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: 400,
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Shipping Type',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.nameController,
                      validator: controller.nameValidator,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
                      height: spaceBetweenFields,
                    ),
                    TextFormField(
                      controller: controller.priceController,
                      validator: controller.priceValidator,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Price',
                      ),
                    ),
                    const SizedBox(
                      height: spaceBetweenFields,
                    ),
                    TextFormField(
                      controller: controller.minArrivalTimeController,
                      validator: controller.minArrivalTimeValidator,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Min Arrival Time (In days)',
                      ),
                    ),
                    const SizedBox(
                      height: spaceBetweenFields,
                    ),
                    TextFormField(
                      controller: controller.maxArrivalTimeController,
                      validator: controller.maxArrivalTimeValidator,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'Max Arrival Time (In days)',
                      ),
                    ),
                    const SizedBox(
                      height: spaceBetweenFields,
                    ),
                    ElevatedButton(
                      onPressed: controller.addNewShippingType,
                      child: const Text('Add New Shipping Type'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
