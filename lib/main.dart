import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_bloc/di/injection.dart';
import 'package:getx_bloc/screens/article_detail_page/article_detail_controller.dart';
import 'package:getx_bloc/screens/article_detail_page/article_detail_page.dart';
import 'package:getx_bloc/screens/the_category_articles/the_category_article_binding.dart';
import 'package:getx_bloc/screens/the_category_articles/the_category_articles.dart';
import 'package:getx_bloc/screens/the_front_page/front_page_binding.dart';
import 'package:getx_bloc/screens/the_front_page/the_front_page.dart';
import 'package:getx_bloc/screens/the_search/search_page_binding.dart';
import 'package:getx_bloc/screens/the_search/the_search_page.dart';

void main() async {
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'Bloggy',
      debugShowCheckedModeBanner: false,
      initialRoute: TheRoutes.frontPage.routeName,
      getPages: PageRoutes.getPages,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey.shade800,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class PageRoutes {
  static List<GetPage> getPages = [
    GetPage(
      name: TheRoutes.frontPage.routeName,
      page: () => const TheFrontPage(),
      binding: FrontPageBinding(),
    ),
    GetPage(
      name: TheRoutes.searchPage.routeName,
      page: () => const TheSearchPage(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: TheRoutes.categoryArticles.routeName,
      page: () => const TheCategoryArticles(),
      binding: CategoryArticleBinding(),
    ),
    GetPage(
      name: TheRoutes.categoryNSubCategoryArticles.routeName,
      page: () => const TheCategoryArticles(),
      binding: CategoryArticleBinding(),
    ),
    //ArticleDetailPage
    GetPage(
      name: TheRoutes.articleDetail.routeName,
      page: () => const ArticleDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ArticleDetailController>(() => ArticleDetailController());
      }),
    )
  ];

  static void navigateTo(TheRoutes page, [dynamic arguments]) =>
      Get.toNamed(page.routeName, arguments: arguments);
}

enum TheRoutes {
  frontPage("/"),
  searchPage("/search"),
  categoryArticles("/by_category"),
  categoryNSubCategoryArticles("/by_category_n_sub_category"),
  articleDetail("/article_detail");

  final String route;

  const TheRoutes(this.route);

  String get routeName => route;
}
