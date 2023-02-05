import 'package:get/get.dart';
import 'package:sales_app/models/category.dart';
import 'package:sales_app/service/category.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
  RxBool isLoading = RxBool(false);
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  fetchCategory() async {
    try {
      isLoading.value = true;
      List response = await CategoryClient.fetchCategory();

      categoryList.assignAll(response.map((e) => CategoryModel.fromJson(e)));

      isLoading.value = false;
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
