import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/screens/createproduct.dart';
import 'package:sales_app/service/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductController extends GetxController {
  CategoryController categoryController = Get.find<CategoryController>();
  RxList<ProductModel> productList = RxList<ProductModel>([]);
  RxBool isLoading = RxBool(false);
  TextEditingController pnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxString initialCategory = RxString('Fruits');
  var categoryId = "".obs;
  RxBool isSave = RxBool(false);
  ImagePicker picker = ImagePicker();
  XFile image = XFile('');
  RxList cart = RxList([]);
  RxInt total = RxInt(0);
  String imageUrl = "";
  RxBool isUploading = RxBool(false);
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  addToCart(ProductModel product) async {
    print("aasdasdasdas");
    int index = cart.indexWhere((element) => element.sId == product.sId);
    if (index != -1) {
      print("my indexsa $index,${cart[index].count}");
      cart[index].count += 1;
      cart[index].total = cart[index].count * cart[index].price;
      getTotalCart();
    } else {
      cart.add(product);
      product.count = 1;
      product.total = product.price;
      getTotalCart();
    }
  }

  removeFromCart(ProductModel product) {
    int index = cart.indexWhere((element) => element.sId == product.sId);
    if (index != -1) {
      cart.removeWhere((element) => element.sId == cart[index].sId);
      Fluttertoast.showToast(msg: "${product.name} removed");
    }
    getTotalCart();
  }

  getTotalCart() {
    print("dasdasdasdas");
    try {
      cart.map((element) {
        total.value += element.total as int;
        print(total.value);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  clearCart() {
    cart.clear();
    total.value = 0;
  }

  fetchProducts() async {
    try {
      isLoading.value = true;
      var response = await ProductClient.fetchProducts();
      List data = response['body'];
      productList.assignAll(data.map((e) => ProductModel.fromJson(e)));
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  fetchByCategory(String id) async {
    try {
      isLoading.value = true;

      List response = await ProductClient.fetchByCategory(id);
      productList.assignAll(response.map((e) => ProductModel.fromJson(e)));
      productList.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  createProduct() async {
    try {
      isLoading.value = true;
      String id = await Functions().userId();
      Map<String, dynamic> data = {
        "name": pnameController.text,
        "description": descriptionController.text,
        "price": int.parse(priceController.text),
        "count": int.parse(countController.text),
        "owner": id,
        "category": categoryId.value,
        "imageurl": imageUrl.toString(),
      };

      var result = await ProductClient.createProduct(data);
      if (result['status'] == 200) {
        productList.refresh();
        disposer();
      }
      isLoading.value = false;
    } catch (e, s) {
      printError(info: "$e", logFunction: () => print("$e,$s"));
    }
  }

  disposer() {
    pnameController.clear();
    descriptionController.clear();
    priceController.clear();
    countController.clear();
    image == null;
  }
}
