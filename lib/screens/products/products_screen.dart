import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_conrol_panel/screens/products/products_controller.dart';

import 'components/form.dart';
import 'components/images_area.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                // width: 400,
                // height: 500,
                child: DropImagesArea(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
