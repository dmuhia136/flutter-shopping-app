import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/widgets/inputs.dart';

class Search extends StatelessWidget {
  Search({super.key});
  ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Search Products"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomInput(
                controller: productController.searchController,
                hint: "Enter search word",
                enabled: true,
                obscure: false,
                label: "Search",
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.7,
              //   child: ListView.builder(itemBuilder: (ctx, index) {
              //     return Container();
              //   }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
