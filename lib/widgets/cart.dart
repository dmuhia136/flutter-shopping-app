import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/models/product.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    productController.clearCart();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Clear"),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: productController.cart.length,
                    itemBuilder: (context, index) {
                      ProductModel product =
                          productController.cart.elementAt(index);
                      return ListTile(
                          title: Row(
                            children: [
                              Text(product.name.toString()),
                            ],
                          ),
                          subtitle: Text(product.count.toString()),
                          trailing: Text("\$ ${product.price}"),
                          leading: LottieBuilder.asset(
                              "assets/images/products.json"));
                    }),
              ),
            ),
            Expanded(child: Text("")),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                  Obx(() => Text(
                        productController.total.value.toString(),
                        style: GoogleFonts.lato(fontSize: 20),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
