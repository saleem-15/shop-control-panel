import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customers_controller.dart';

class CustomersScreen extends GetView<CustomersController> {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers',
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
