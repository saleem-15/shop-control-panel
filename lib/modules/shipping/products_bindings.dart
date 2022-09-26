import 'package:get/get.dart';
import 'package:shop_conrol_panel/modules/products/controllers/products_controller.dart';

class ProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController(), permanent: true);
  }
}
