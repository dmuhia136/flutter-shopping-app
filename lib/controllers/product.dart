import 'package:get/get.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/service/product.dart';

class ProductController extends GetxController {
  RxList<ProductModel> productList = RxList<ProductModel>([]);
  RxBool isLoading = RxBool(false);
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  fetchProducts() async {
    try {
      isLoading.value = true;
      List response = await ProductClient.fetchProducts();

      productList.assignAll(response.map((e) => ProductModel.fromJson(e)));

      isLoading.value = false;
    } catch (e) {
      print(e);
      Get.snackbar("err", "$e");
    }
  }
}
