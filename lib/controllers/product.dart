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
      cart.add(product);

    // int item = cart.indexOf(product);
    // if (item != -1) {
    //   cart.add(product);
    //   print("$product is found at index $item");
    //   // product.count = product.count! + 1;
    //   // product.price = product.price! * product.count!;
    //   total += product.price!;
    //   print(total);
    // }
    //  else {
    //   cart.add(product);
    //   product.count = product.count! + 1;
    //   product.price = product.price! * product.count!;
    //   total += product.price!;
    //   print(total);
    // }
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
      print(data);

      var result = await ProductClient.createProduct(data);
      print("rsdajs $result");
      if (result['status'] == 200) {
        productList.refresh();
        disposer();
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  disposer() {
    pnameController.clear();
    descriptionController.clear();
    priceController.clear();
    countController.clear();
    image == null;
  }

  uploadImage(String url, String name) async {
    try {
      isUploading.value = true;
      final _firebaseStorage = FirebaseStorage.instance;
      var file = File(url);
      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/$name')
            .putFile(file)
            .whenComplete(() => null);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print("url da aaaa $downloadUrl");
        imageUrl = downloadUrl;
        Fluttertoast.showToast(
            msg: "Image uploaded",
            backgroundColor: Colors.green,
            textColor: Colors.black);
        isUploading.value = false;
      } else {
        Fluttertoast.showToast(
            msg: "Image upload failed",
            backgroundColor: Colors.red,
            textColor: Colors.white);
        isUploading.value = false;
        print('No Image Path Received');
      }
    } catch (e) {}
  }
}
