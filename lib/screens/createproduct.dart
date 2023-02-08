import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/models/category.dart';
import 'package:sales_app/service/category.dart';
import 'package:sales_app/service/product.dart';
import 'package:sales_app/widgets/inputs.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct({super.key});
  ProductController productController = Get.find<ProductController>();
  CategoryController categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: 40,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.cancel)),
                  SizedBox(
                    width: 70,
                  ),
                  Text(
                    "Create product",
                    style: GoogleFonts.lato(fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInput(
                  controller: productController.pnameController,
                  hint: "Product name",
                  label: "Product name:",
                  obscure: false,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomInput(
                  controller: productController.descriptionController,
                  hint: "Product description",
                  label: "Product descriptions:",
                  obscure: false,
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () async {
                      productController.image = (await productController.picker
                          .pickImage(source: ImageSource.gallery))!;
                      print(productController.image);
                    },
                    child: Text("Select image")),
                productController.image.path.length == 0
                    ? Text("")
                    : Stack(
                        // clipBehavior: Clip.none,
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              )),

                          Image.file(
                            File(
                              productController.image.path,
                            ),
                            height: 30,
                            width: 30,
                          ),
                          // Icon(
                          //   Icons.cancel,
                          //   color: Colors.redAccent,
                          // ),
                        ],
                      ),
                SizedBox(
                  height: 15,
                ),
                // Text(categoryController.categoryList.length.toString()),
                Obx(
                  () => DropdownButton(
                      hint: Text("Select category"),
                      items: categoryController.categoryList.map((item) {
                        return DropdownMenuItem(
                          value: item.sId.toString(),
                          child: Text(item.name.toString()),
                        );
                      }).toList(),
                      onChanged: ((value) {
                        print(value);
                        productController.categoryId = value as RxString;
                      })),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomInput(
                  controller: productController.countController,
                  hint: "Product count",
                  label: "Product count:",
                  obscure: false,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomInput(
                  controller: productController.priceController,
                  hint: "Product price",
                  label: "Product price:",
                  obscure: false,
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    productController.createProduct();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 38, 175, 193)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("Create product")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
