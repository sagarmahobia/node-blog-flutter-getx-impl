import 'package:get/get.dart';
import 'package:getx_bloc/di/injection.dart';
import 'package:getx_bloc/network/blog_service.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/views/the_state.dart';

class FrontPageController extends GetxController {
  final client = getIt<BlogService>();

  Rx<RxResponse> articleListModel = RxResponseLoading().obs;

  var count = 0.obs;

  @override
  void onInit() {
    getArticles();
    super.onInit();
  }

  Future<void> getArticles() async {
    articleListModel = RxResponseLoading().obs;
    update();

    final response = await client.allArticles();

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
