import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/controllers/chatController.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/controllers/shopcontroller.dart';
import 'package:sales_app/models/category.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/models/shop.dart';
import 'package:sales_app/screens/messages.dart';
import 'package:sales_app/screens/onboarding/login.dart';
import 'package:sales_app/screens/product_details.dart';
import 'package:sales_app/screens/profile.dart';
import 'package:sales_app/screens/search.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ImagePicker _picker = ImagePicker();

  AddController addController = Get.put(AddController());

  AuthController authController = Get.put(AuthController());

  CategoryController categoryController = Get.find<CategoryController>();

  ProductController productController = Get.find<ProductController>();

  ChatController chatController = Get.find<ChatController>();

  ShopController shopController = Get.find<ShopController>();

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await productController.fetchProducts();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Obx(
                    () => authController.userData.value == null
                        ? Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                color: Colors.cyan[50],
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Welcome to our market",
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(Login());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Login"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ).animate().slide()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: user != null ||
                                                authController.userData.value !=
                                                    null
                                            ? Colors.green
                                            : Colors.grey[900],
                                      )),
                                  InkWell(
                                    onTap: () async {
                                      await authController.fetchUserProducts();
                                      Get.to(() => Profile());
                                    },
                                    child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                            "${authController.userData.value!.profileimage}")),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back,',
                                    style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    '${authController.userData.value!.firstname} ${authController.userData.value!.lastname}',
                                    style: GoogleFonts.lato(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    '${authController.userData.value!.shop == null ? '' : authController.userData.value!.shop!.name}',
                                    style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Get.to(Messages());
                                      await chatController.fetchMessages();
                                    },
                                    child: Icon(Icons.message),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isDismissible: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(25.0)),
                                          ),
                                          context: context,
                                          builder: (BuildContext contex) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        productController
                                                            .clearCart();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white),
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            productController
                                                                .cart.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          ProductModel product =
                                                              productController
                                                                  .cart
                                                                  .elementAt(
                                                                      index);
                                                          return ListTile(
                                                              title: Row(
                                                                children: [
                                                                  Text(product
                                                                      .name
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              subtitle: Column(
                                                                children: [
                                                                  Text(product
                                                                      .count
                                                                      .toString()),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        productController
                                                                            .removeFromCart(product);
                                                                      },
                                                                      child: Text(
                                                                          "Remove"))
                                                                ],
                                                              ),
                                                              trailing: Text(
                                                                  "\$ ${product.total}"),
                                                              leading: LottieBuilder
                                                                  .asset(
                                                                      "assets/images/products.json"));
                                                        }),
                                                  ),
                                                ),
                                                Expanded(child: Text("")),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "Total",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Obx(() => Text(
                                                            productController
                                                                .total.value
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .lato(
                                                                    fontSize:
                                                                        20),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: CircleAvatar(
                                        radius: 20,
                                        child: LottieBuilder.asset(
                                            "assets/images/lf30_x2lzmtdl.json")),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await authController.logout();
                                    },
                                    child: Icon(Icons.logout),
                                  ),
                                ],
                              ),
                            ],
                          ).animate().slide(),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => Search());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 227, 224, 224)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Text("Search pinnaple"),
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.filter_alt,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 30,
                    child: categoryController.isLoading == true
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryController.categoryList.length,
                                itemBuilder: (context, index) {
                                  CategoryModel category = categoryController
                                      .categoryList
                                      .elementAt(index);
                                  return InkWell(
                                    onTap: () {
                                      productController.fetchByCategory(
                                          category.sId.toString());
                                      productController.productList.refresh();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 10, right: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              category.name.toString(),
                                              style: GoogleFonts.lato(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  );
                                })
                            .animate()
                            .moveY(duration: Duration(milliseconds: 1000)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Popular products",
                          style: GoogleFonts.actor(color: Colors.redAccent)),
                    ],
                  ),
                  Obx(
                    () => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: productController.isLoading.value == true
                            ? Center(child: CircularProgressIndicator())
                            : productController.productList.length == 0
                                ? Text("No products yet")
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      ProductModel product = productController
                                          .productList
                                          .elementAt(index);
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => ProductDetails(
                                                      product: product,
                                                    ));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                child: product.imageurl == ''
                                                    ? LottieBuilder.asset(
                                                        "assets/images/products.json")
                                                    : Image.network(
                                                        "${product.imageurl.toString()}"),
                                              ),
                                            ),
                                            Text('${product.name}'),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                productController
                                                    .addToCart(product);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "${product.name} added to cart");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color:
                                                        CustomColors().primary),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    "Add to cart",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) {
                                      return SizedBox(
                                        width: 15,
                                      );
                                    },
                                    itemCount:
                                        productController.productList.length,
                                  )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Popular shops",
                          style: GoogleFonts.actor(color: Colors.redAccent)),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: shopController.shopList.length == 0
                          ? Text("No shops yet")
                          : ListView.builder(
                              itemCount: shopController.shopList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (cxt, index) {
                                ShopModel shop =
                                    shopController.shopList.elementAt(index);
                                print(shop.sId);
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: LottieBuilder.asset(
                                              "assets/images/shop.json"),
                                        ),
                                      ),
                                      Text(
                                        '${shop.name}',
                                        style: GoogleFonts.lato(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                );
                              }))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
