import 'package:dio/dio.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/network/models/categories_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'blog_service.g.dart';

@RestApi(baseUrl: "http://localhost:3000")
@singleton
abstract class BlogService {
  @factoryMethod
  factory BlogService(
    Dio dio,
  ) = _BlogService;

  @GET("/category/parents")
  Future<CategoryModel> getCategories();

  @GET("/category/children")
  Future<CategoryModel> getSubCategories(
    @Query("id") String parentId,
  );

  @GET("/articles/list")
  Future<ArticleListModel> allArticles();

  @POST("/articles/by_category")
  Future<ArticleListModel> getArticlesByCategory(
    @Query("categoryId") String category,
    @Query("subCategoryId") String? subCategory,
  );

  @POST("/articles/filter")
  Future<ArticleListModel> searchArticles(
    @Body() SearchInputModel searchInputModel,
  );

  @GET("/articles/info")
  Future<ArticleInfoModel> getArticleDetail({
    @Query("id") required String id,
  });
}

class SearchInputModel {
  //{
  //   "category": "string",
  //   "subCategories": [
  //     "string"
  //   ],
  //   "tags": [
  //     "string"
  //   ],
  //   "search": "string"
  // }

  final String search;

  SearchInputModel({
    required this.search,
  });

  Map<String, dynamic> toJson() => {
        "search": search,
      };
}
