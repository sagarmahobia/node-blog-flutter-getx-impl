import 'package:get/get.dart';
import 'package:getx_bloc/di/injection.dart';
import 'package:getx_bloc/network/blog_service.dart';
import 'package:getx_bloc/network/models/categories_model.dart';
import 'package:getx_bloc/views/the_state.dart';

class CategorySliderController extends GetxController {
  var categorySliderModel = RxResponseLoading();
  final client = getIt<BlogService>();

  @override
  void onInit() {
    super.onInit();
    print('CategorySliderController onInit');
  }

  Rx<RxResponse> categoryModel = RxResponse().obs;

  Future<void> getCategories(
    String? parentId,
  ) async {
    categoryModel = RxResponseLoading().obs;
    update();

    // final response = await client.getCategories();

    CategoryModel response;
    if (parentId == null) {
      response = await client.getCategories();
    } else {
      response = await client.getSubCategories(parentId!);
    }

    if (response.success ?? false) {
      categoryModel = RxResponseSuccess<CategoryModel>(
        data: response,
      ).obs;
    } else {
      categoryModel = RxResponseError(
        error: response.message,
      ).obs;
    }
    update();
  }
}
