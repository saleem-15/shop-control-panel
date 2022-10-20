import 'package:get/get.dart';

import 'controllers/products_controller.dart';

class ProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController(), permanent: true);
  }
}
