import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/screens/article_detail_page/article_detail_controller.dart';
import 'package:getx_bloc/views/the_state.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleDetailPageArgument {
  final String id;

  ArticleDetailPageArgument({required this.id});
}

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  var arguments = Get.arguments as ArticleDetailPageArgument;

  var controller = Get.find<ArticleDetailController>();

  @override
  void initState() {
    super.initState();
    controller.getArticleDetail(arguments.id);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Article Detail"),
      ),
      child: SafeArea(
        child: GetBuilder<ArticleDetailController>(
          init: controller,
          builder: (controller) {
            var model = controller.articleDetail.value;
            if (model is RxResponseSuccess<ArticleModel>) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    FadeInImage.memoryNetwork(
                      image:
                          "https://images.unsplash.com/photo-1626593261859-4fe4865d8cb1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8MTYlM0E5fGVufDB8fDB8fHww&w=1000&q=80",
                      placeholder: kTransparentImage,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                      imageErrorBuilder: (_, __, ___) => Container(
                        color: Colors.blueGrey.shade50,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.data?.title ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.data?.description ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (model is RxResponseError) {
              return Center(
                child: Text(
                  model.error ?? "Something went wrong",
                ),
              );
            }

            return const CupertinoActivityIndicator();
          },
        ),
      ),
    );
  }
}
