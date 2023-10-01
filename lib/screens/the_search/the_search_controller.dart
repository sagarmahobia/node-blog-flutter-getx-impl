import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:getx_bloc/di/injection.dart';
import 'package:getx_bloc/network/blog_service.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/the_content.dart';
import 'package:getx_bloc/views/the_state.dart';

class SearchPageController extends GetxController {
  final client = getIt<BlogService>();

  final searchController = TextEditingController();

  var articleListModel = RxResponse().obs;

  Future<void> onSearch() async {
    final query = searchController.text;
    articleListModel = RxResponseLoading().obs;

    update();

    final response = await client.searchArticles(
      SearchInputModel(
        search: query,
      ),
    );

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
