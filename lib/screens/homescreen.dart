import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/category.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/screens/createproduct.dart';
import 'package:sales_app/screens/messages.dart';
import 'package:sales_app/screens/onboarding/login.dart';
import 'package:sales_app/screens/product_details.dart';
import 'package:sales_app/widgets/drawer.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  String? title;
  HomeScreen({super.key, this.title});
  List<String> fruits = [
    "Fruits",
    "Vagetables",
    "Dairy",
    "Grains",
    "Meat",
    "Soft drinks",
  ];
  final ImagePicker _picker = ImagePicker();
  AddController addController = Get.put(AddController());
  AuthController authController = Get.put(AuthController());
  CategoryController categoryController = Get.find<CategoryController>();
  ProductController productController = Get.find<ProductController>();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    authController.checkLogin();
    final File fileImage = File(addController.image.value.path);

    print("${addController.image.value.path}");
    // File newPhoto = File(addController.image.value.path);
    pickImage() async {
      final XFile? pick = await _picker.pickImage(source: ImageSource.camera);
    }

    pickGallary() async {
      final XFile? pick = await _picker.pickImage(source: ImageSource.gallery);
    }

    return SafeArea(
      child: Scaffold(
          floatingActionButton: SpeedDial(
            child: Icon(Icons.add),
            speedDialChildren: <SpeedDialChild>[
              SpeedDialChild(
                child: Icon(Icons.insert_emoticon_outlined),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                label: 'Create new product!',
                onPressed: () {
                  Get.to(CreateProduct());
                },
                closeSpeedDialOnPressed: false,
              ),
              SpeedDialChild(
                child: Icon(Icons.shop),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                label: 'Create shop!',
                onPressed: () {},
                closeSpeedDialOnPressed: false,
              ),

              //  Your other SpeedDialChildren go here.
            ],
          ),
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.cyan[50],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            border:
                                                Border.all(color: Colors.grey),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 5,
                                            backgroundColor: user != null
                                                ? Colors.green
                                                : Colors.grey[900],
                                          )),
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile.png'),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Get.to(Messages());
                                        },
                                        child: Icon(Icons.message),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get your fresh items',
                                style: GoogleFonts.lato(fontSize: 30),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'with',
                                    style: GoogleFonts.lato(fontSize: 30),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Hay Markets",
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
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
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search pinnaple',
                                  hintStyle: GoogleFonts.lato(fontSize: 20),
                                  icon: const Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Colors.redAccent,
                                  )),
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
                                    itemCount:
                                        categoryController.categoryList.length,
                                    itemBuilder: (context, index) {
                                      CategoryModel category =
                                          categoryController.categoryList
                                              .elementAt(index);
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 10, right: 10),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[700],
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                category.name.toString(),
                                                style: GoogleFonts.lato(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      );
                                    })
                                .animate()
                                .moveY(duration: Duration(milliseconds: 1000)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 10.0,
                                children:
                                    List.generate(
                                        productController.productList.length,
                                        (index) {
                                  ProductModel product = productController
                                      .productList
                                      .elementAt(index);
                                  return InkWell(
                                    onTap: () => Get.to(ProductDetails(
                                      product: product,
                                    )),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/peach.png'))),
                                        child: Text('${product.name}'),
                                      ),
                                    ),
                                  );
                                }))
                            .animate()
                            .moveY(duration: Duration(milliseconds: 1000))
                            .fadeIn(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
