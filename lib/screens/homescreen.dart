import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/controllers/addController.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/controllers/category.dart';
import 'package:sales_app/controllers/chatController.dart';
import 'package:sales_app/controllers/product.dart';
import 'package:sales_app/controllers/shopcontroller.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/category.dart';
import 'package:sales_app/models/product.dart';
import 'package:sales_app/models/shop.dart';
import 'package:sales_app/screens/cart.dart';
import 'package:sales_app/screens/createproduct.dart';
import 'package:sales_app/screens/homepage.dart';
import 'package:sales_app/screens/messages.dart';
import 'package:sales_app/screens/onboarding/login.dart';
import 'package:sales_app/screens/product_details.dart';
import 'package:sales_app/screens/profile.dart';
import 'package:sales_app/screens/search.dart';
import 'package:sales_app/widgets/button.dart';
import 'package:sales_app/widgets/drawer.dart';
import 'package:sales_app/widgets/inputs.dart';
import 'package:sales_app/widgets/navbar.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  String? title;
  HomeScreen({super.key, this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  ChatController chatController = Get.find<ChatController>();

  ShopController shopController = Get.find<ShopController>();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Messages(),
    Cart(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void onInit() {
    _onItemTapped(0);
  }

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
          bottomNavigationBar: Obx(
            () => authController.userData.value != null
                ? FloatingNavbar(
                    backgroundColor: CustomColors().primary,
                    onTap: _onItemTapped,
                    currentIndex: _selectedIndex,
                    items: [
                      FloatingNavbarItem(icon: Icons.home, title: 'Home'),
                      FloatingNavbarItem(
                          icon: Icons.chat_bubble_outline, title: 'Chats'),
                      FloatingNavbarItem(
                          icon: Icons.production_quantity_limits,
                          title: 'Cart'),
                      FloatingNavbarItem(
                          icon: Icons.settings, title: 'Settings'),
                    ],
                  )
                : Text(""),
          ),
          floatingActionButton: Obx(
            () => authController.userData.value != null
                ? SpeedDial(
                    child: Icon(Icons.add),
                    openBackgroundColor: CustomColors().secondary,
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
                        child: Icon(Icons.category),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        label: 'Create new category!',
                        onPressed: () {
                          showModalBottomSheet(
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Divider(
                                            color: Colors.grey[600],
                                            thickness: 2.0,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomInput(
                                          controller: categoryController
                                              .catNameController,
                                          hint: "Category Name",
                                          obscure: false,
                                          enabled: true,
                                          label: "Category Name"),
                                      Expanded(child: Text("")),
                                      shopController.isLoading.value == true
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : InkWell(
                                              onTap: () async {
                                                await categoryController
                                                    .createCategory();
                                              },
                                              child: CustomButton(
                                                  text: "Create Shop")),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        closeSpeedDialOnPressed: false,
                      ),
                      SpeedDialChild(
                        child: Icon(Icons.shop),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        label: 'Create shop!',
                        onPressed: () {
                          showModalBottomSheet(
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Divider(
                                            color: Colors.grey[600],
                                            thickness: 2.0,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomInput(
                                          controller:
                                              shopController.shopNameController,
                                          hint: "Shop Name",
                                          obscure: false,
                                          enabled: true,
                                          label: "Shop Name"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CustomInput(
                                          controller:
                                              shopController.locationController,
                                          hint: "Location",
                                          obscure: false,
                                          label: "Location",
                                          enabled: true),
                                      Expanded(child: Text("")),
                                      shopController.isLoading.value == true
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : InkWell(
                                              onTap: () async {
                                                await shopController
                                                    .createShops();
                                              },
                                              child: CustomButton(
                                                  text: "Create Shop")),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        closeSpeedDialOnPressed: false,
                      ),

                      //  Your other SpeedDialChildren go here.
                    ],
                  )
                : SpeedDial(
                    child: Icon(Icons.add),
                    speedDialChildren: <SpeedDialChild>[
                      SpeedDialChild(
                        child: Icon(Icons.insert_emoticon_outlined),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        label: "Please login in first",
                        onPressed: () {
                          Get.to(Login());
                        },
                        closeSpeedDialOnPressed: false,
                      ),
                    ],
                  ),
          ),
          drawer: CustomDrawer(),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          )),
    );
  }
}
