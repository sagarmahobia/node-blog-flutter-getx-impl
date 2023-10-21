import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_bloc/main.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/network/models/categories_model.dart';
import 'package:getx_bloc/screens/the_category_articles/the_category_articles.dart';
import 'package:getx_bloc/screens/the_front_page/front_page_controller.dart';
import 'package:getx_bloc/the_content.dart';
import 'package:getx_bloc/views/category/category_slider.dart';
import 'package:getx_bloc/views/the_headline_slider.dart';
import 'package:getx_bloc/views/the_post_item.dart';
import 'package:getx_bloc/views/the_search_bar.dart';
import 'package:getx_bloc/views/the_state.dart';
import 'package:google_fonts/google_fonts.dart';

class TheFrontPage extends StatefulWidget {
  const TheFrontPage({super.key});

  @override
  State<TheFrontPage> createState() => _TheFrontPageState();
}

class _TheFrontPageState extends State<TheFrontPage> {
  final controller = Get.find<FrontPageController>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Text(
          'Bloggy',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey.shade800,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const TheSearchBar(),

              // GetBuilder<FrontPageController>(
              //   builder: (context) {
              //     return getCategoriesSlider();
              //   },
              //   init: controller,
              // ),
              CategorySlider(
                key: UniqueKey(),
              ),
              // const TheHeadLineSlider(),
              // const SizedBox(
              //   height: 16,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Text(
                  'Suggestions for you',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
              ),
              GetBuilder(
                builder: (context) {
                  var articleListModel = controller.articleListModel.value;
                  if (articleListModel is RxResponseError) {
                    return Center(
                      child: Text(
                        articleListModel.error ?? "Something went wrong",
                      ),
                    );
                  } else if (articleListModel
                      is RxResponseSuccess<List<ArticleModel>>) {
                    return Column(
                      children: articleListModel.data
                              ?.map(
                                (e) => ThePostItem(
                                  sliderItem: e,
                                ),
                              )
                              .toList() ??
                          [],
                    );
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                init: controller,
              )
            ],
          ),
        ),
      ),
    );
  }
}
