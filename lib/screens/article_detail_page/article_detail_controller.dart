import 'package:get/get.dart';
import 'package:getx_bloc/di/injection.dart';
import 'package:getx_bloc/network/blog_service.dart';
import 'package:getx_bloc/views/the_state.dart';

class ArticleDetailController extends GetxController{


  final restClient  = getIt<BlogService>();

  Rx<RxResponse> articleDetail = RxResponseLoading().obs;

  void getArticleDetail(String id) {
    articleDetail = RxResponseLoading().obs;
    restClient.getArticleDetail(id: id).then((value) {
      if (value.success ?? false) {
        articleDetail = RxResponseSuccess(data: value.data).obs;
      } else {
        articleDetail = RxResponseError(error: value.message ?? '').obs;
      }
      update();
    });
  }
}
