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
import 'package:sales_app/models/category.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/screens/messages.dart';
import 'package:sales_app/screens/product_details.dart';
import 'package:sales_app/widgets/drawer.dart';

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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Get.defaultDialog(
                  title: "Choose a camera",
                  onCancel: () => Navigator.pop(context),
                  content: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () => {pickImage()}, child: Text("Camera")),
                        InkWell(
                            onTap: () {
                              pickGallary();
                            },
                            child: Text("Gallery"))
                      ],
                    ),
                  ));

              // print("dasdasdas,${pick}");
              // addController.image.value = pick!;
            },
            child: Icon(Icons.add_a_photo),
          ),
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: GoogleFonts.lato(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '${authController.userData.value!.firstname} ${authController.userData.value!.lastname}',
                                style: GoogleFonts.lato(
                                    fontSize: 17, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              Get.to(Messages());
                              // showModalBottomSheet(
                              //     context: context,
                              //     builder: (BuildContext bc) {
                              //       return Container(
                              //         child: new Wrap(
                              //           children: <Widget>[
                              //             new ListTile(
                              //                 leading:
                              //                     new Icon(Icons.music_note),
                              //                 title: new Text('Music'),
                              //                 onTap: () => {}),
                              //             new ListTile(
                              //               leading: new Icon(Icons.videocam),
                              //               title: new Text('Video'),
                              //               onTap: () => {},
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     });
                              // await GoogleSignIn().signOut();
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/briefcase.jpg'),
                            ),
                          ),
                        ],
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
                                  CategoryModel category = categoryController
                                      .categoryList
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
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            category.name.toString(),
                                            style: GoogleFonts.lato(
                                                color: Colors.white),
                                          ),
                                        )),
                                  );
                                }),
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
                            children: List.generate(productController.productList.length, (index) {
                              ProductModel product = productController
                                  .productList
                                  .elementAt(index);
                              return InkWell(
                                onTap: () => Get.to(ProductDetails()),
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
                            })),
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
