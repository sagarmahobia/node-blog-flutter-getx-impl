import 'package:get/get.dart';
import 'package:getx_bloc/di/injection.dart';
import 'package:getx_bloc/network/blog_service.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/views/category/category_slider_controller.dart';
import 'package:getx_bloc/views/the_state.dart';

class CategoryPageController extends GetxController {


  final client = getIt<BlogService>();

  Rx<RxResponse> articleListModel = RxResponse().obs;

  Future<void> getArticlesByCategory(
      String category, String? subCategory) async {
    articleListModel = RxResponseLoading().obs;
    update();

    final response = await client.getArticlesByCategory(category, subCategory);

    if (response.success ?? false) {
      articleListModel = RxResponseSuccess<List<ArticleModel>>(
        data: response.data ?? [],
      ).obs;
    } else {
      articleListModel = RxResponseError(
        error: response.message ?? '',
      ).obs;
    }
    update();
  }
}
