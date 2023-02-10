import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/models/product.dart';

class ProductDetails extends StatelessWidget {
  ProductModel product;
  ProductDetails({super.key, required this.product});
  AddController addController = Get.put(AddController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: (() => Get.back()),
                      ),
                    )),
                Positioned(
                    top: 10,
                    right: 5,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('assets/images/briefcase.jpg'),
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 1.0,
                  decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 218, 172, 227),
                      image: DecorationImage(image: NetworkImage('${product.imageurl}'))),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name.toString(),
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        "\$ ${product.price}",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => addController.remove(),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 224, 121, 121),
                          child: Icon(Icons.remove),
                        ),
                      ),
                      Obx(
                        () => Text(
                          addController.num.toString(),
                          style: GoogleFonts.lato(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () => {addController.add()},
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 112, 207, 88),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
