import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/screens/createproduct.dart';
import 'package:sales_app/service/product.dart';

class ProductController extends GetxController {
  CategoryController categoryController = Get.find<CategoryController>();
  RxList<ProductModel> productList = RxList<ProductModel>([]);
  RxBool isLoading = RxBool(false);
  TextEditingController pnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  RxString initialCategory = RxString('Fruits');
var categoryId = "".obs ;
  RxBool isSave = RxBool(false);
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
      Get.snackbar("mydaserr", "$e");
    }
  }

  createProduct() async {
    try {
      isSave.value = true;
      String id = await Functions().userId();

      

      Map<String, dynamic> data = {
        "name": pnameController.text,
        "description": descriptionController.text,
        "price": int.parse(priceController.text),
        "count": int.parse(countController.text),
        "owner": id,
        "category": categoryId.value
      };
      print(data);

      var result = await ProductClient.createProduct(data);
      print("rsdajs $result");
      if (result['status'] == 200) {
        productList.add(result['body']);
      }
      isSave.value = false;
    } catch (e) {
      print(e);
    }
  }

  disposer() {
    pnameController.clear();
    descriptionController.clear();
    priceController.clear();
    countController.clear();
  }
}
