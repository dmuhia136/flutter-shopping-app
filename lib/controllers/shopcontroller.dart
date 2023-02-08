import 'package:get/get.dart';
import 'package:sales_app/models/shop.dart';
import 'package:sales_app/service/shop.dart';

class ShopController extends GetxController {
  RxList<ShopModel> shopList = RxList<ShopModel>([]);

  void onInit() {
    super.onInit();
    fetchShops();
  }

  fetchShops() async {
    List response = await ShopClient.fetchAllShops();
    shopList.assignAll(response.map((e) => ShopModel.fromJson(e)));
  }
}
