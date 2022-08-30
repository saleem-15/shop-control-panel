import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/config/theme/light_theme_colors.dart';

import '../products_controller.dart';
import 'enter_color.dart';
import 'enter_size.dart';

class ProductInfoForm extends GetView<ProductsController> {
  const ProductInfoForm({Key? key}) : super(key: key);

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

          /// drop down button (for choosing category)
          Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: searchTextfieldColor,
                ),
                dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                isExpanded: true,
                buttonPadding: const EdgeInsets.only(left: 10),
                hint: Text(
                  'Select Product Category',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: controller.categories
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: controller.chosenCategory.value,
                onChanged: (String? value) => controller.chosenCategory.value = value!,
                buttonHeight: 54,
                itemHeight: 40,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: controller.priceController,
            validator: controller.priceValidator,
            decoration: const InputDecoration(
              hintText: 'Price',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: controller.descriptionController,
            validator: controller.descriptionValidator,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const EnterColors(),
          const SizedBox(
            height: 40,
          ),
          const EnterSize(),
        ],
      ),
    );
  }
}
