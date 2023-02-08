import 'package:get/get.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/controllers/chatController.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/controllers/shopcontroller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<AddController>(AddController(), permanent: true);
    Get.put<CategoryController>(CategoryController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ProductController>(ProductController(), permanent: true);
    Get.put<ShopController>(ShopController(), permanent: true);
  
  }
}