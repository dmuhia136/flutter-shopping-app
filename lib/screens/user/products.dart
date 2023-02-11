import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/screens/product_details.dart';

class Products extends StatelessWidget {
  Products({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: authController.userProducts.length,
              shrinkWrap: true,
              itemBuilder: (cxt, index) {
                ProductModel product =
                    authController.userProducts.elementAt(index);
                return InkWell(
                  onTap: () {
                    Get.to(ProductDetails(product: product));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(product.imageurl.toString())),
                        title: Text(
                          product.name.toString(),
                        ),
                        subtitle: Text("\$ ${product.price}"),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
