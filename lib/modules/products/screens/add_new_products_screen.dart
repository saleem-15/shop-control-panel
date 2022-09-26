import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/config/theme/my_styles.dart';
import '../../category/components/drop_image_area.dart';
import '../components/form.dart';
import '../controllers/add_new_products_controller.dart';

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
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: MyStyles.getInputDecorationTheme(isLightTheme: true),
        ),
        child:  SingleChildScrollView(
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
    );
  }
}
