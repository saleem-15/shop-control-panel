import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/screens/add_product/add_new_products_controller.dart';

import '../../config/theme/light_theme_colors.dart';
import 'components/form.dart';
import 'components/images_area.dart';

class AddNewProductScreen extends GetView<AddNewProductsController> {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: controller.goToProducts,
        ),
        title: Text(
          'Add New Products',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: searchTextfieldColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                      borderSide: const BorderSide(color: searchTextfieldColor, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                      borderSide: const BorderSide(color: searchTextfieldColor, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                      borderSide: const BorderSide(color: searchTextfieldColor, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                      borderSide: const BorderSide(color: searchTextfieldColor, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                      borderSide: const BorderSide(color: searchTextfieldColor, width: 1.5),
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  //this is added to fix a bug
                  controller: ScrollController(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(
                          width: 400,
                          child: ProductInfoForm(),
                        ),
                        Expanded(
                          child: DropImagesArea(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
