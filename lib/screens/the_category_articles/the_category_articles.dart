import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/screens/the_category_articles/the_category_controller.dart';
import 'package:getx_bloc/screens/the_front_page/front_page_controller.dart';
import 'package:getx_bloc/screens/the_search/search_page_binding.dart';
import 'package:getx_bloc/screens/the_search/the_search_controller.dart';
import 'package:getx_bloc/views/category/category_slider.dart';
import 'package:getx_bloc/views/the_post_item.dart';
import 'package:getx_bloc/views/the_state.dart';

class CategoryArguments {
  final String categoryId;
  final String? subCategoryId;

  CategoryArguments(this.categoryId, [this.subCategoryId]);
}

class TheCategoryArticles extends StatefulWidget {
  const TheCategoryArticles({super.key});

  @override
  State<TheCategoryArticles> createState() => _TheCategoryArticlesState();
}

class _TheCategoryArticlesState extends State<TheCategoryArticles> {
  var controller = Get.find<CategoryPageController>();

  var arguments = Get.arguments as CategoryArguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getArticlesByCategory(
        arguments.categoryId,
        arguments.subCategoryId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Category Articles"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: arguments.subCategoryId == null,
              child: CategorySlider(
                key: UniqueKey(),
                categoryId: arguments.categoryId,
              ),
            ),
            GetBuilder(
                init: controller,
                builder: (controller) {
                  var model = controller.articleListModel.value;
                  if (model is RxResponseError) {
                    return Center(
                      child: Text(
                        model.error ?? "Something went wrong",
                      ),
                    );
                  }
                  if (model is RxResponseSuccess<List<ArticleModel>>) {
                    return SingleChildScrollView(
                      child: Column(
                        children: model.data
                                ?.map(
                                  (e) => ThePostItem(
                                    sliderItem: e,
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    );
                  }

                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
