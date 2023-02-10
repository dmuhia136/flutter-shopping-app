import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sales_app/functions/function.dart';
import 'package:sales_app/models/shop.dart';
import 'package:sales_app/service/shop.dart';
import 'package:sales_app/service/userClient.dart';

class ShopController extends GetxController {
  RxList<ShopModel> shopList = RxList<ShopModel>([]);
  TextEditingController shopNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchShops();
  }

  fetchShops() async {
    try {
      List response = await ShopClient.fetchAllShops();
      shopList.addAll(response.map((e) => ShopModel.fromJson(e)));
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      print(e);
    }
  }

  createShops() async {
    try {
      isLoading.value = true;
      final String? id = await Functions().userId();
      Map<String, dynamic> shop = {
        "name": shopNameController.text,
        "location": locationController.text,
        "owner": id,
      };
      var response = await ShopClient.createShops(shop);
      if (response['status'] == 200) {
        Map<String, dynamic> usershop = {"shop": await response['body']['_id']};
        var newResponse = await UserClient.addShopUser(usershop);
        print(newResponse);
      }
      await disposer();
      await fetchShops();
      shopList.refresh();
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  disposer() {
    shopNameController.clear();
    locationController.clear();
  }
}
