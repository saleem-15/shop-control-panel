import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/form.dart';
import 'categories_controller.dart';

class CategoryScreen extends GetView<CategoriesController> {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Existing Categories',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children:
                      controller.categories.map((categoryName) => Chip(label: Text(categoryName))).toList(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                width: 400,
                child: CategoryInfoForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
