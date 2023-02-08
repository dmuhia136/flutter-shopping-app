import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/screens/createproduct.dart';
import 'package:sales_app/service/product.dart';
import 'package:path_provider/path_provider.dart';

class ProductController extends GetxController {
  CategoryController categoryController = Get.find<CategoryController>();
  RxList<ProductModel> productList = RxList<ProductModel>([]);
  RxBool isLoading = RxBool(false);
  TextEditingController pnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  RxString initialCategory = RxString('Fruits');
  var categoryId = "".obs;
  RxBool isSave = RxBool(false);
  ImagePicker picker = ImagePicker();
  XFile image = XFile('');
  RxList cart = RxList([]);
  RxInt total = RxInt(0);

  void onInit() {
    super.onInit();
    fetchProducts();
  }

  addToCart(ProductModel product) async {
    int item = cart.indexOf(product);

    if (item == 1) {
      cart.add(product);
      total.value += product.price!;
    } else {
      cart.add(product);
      total.value += product.price!;
    }
  }

  fetchProducts() async {
    try {
      isLoading.value = true;
      var response = await ProductClient.fetchProducts();
      print("treaas $response");
      List data = response['body'];
      productList.assignAll(data.map((e) => ProductModel.fromJson(e)));
      // productList.assignAll(response.map((e) => ProductModel.fromJson(e)));
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
      uploadImage(image.name, image.path);
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

  uploadImage(String name, String path) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute}/path/to/mountains.jpg";
    final file = File(filePath);

// Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = storageRef
        .child("images/path/to/mountains.jpg")
        .putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          break;
      }
    });
  }
}
