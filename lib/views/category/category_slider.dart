import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_bloc/main.dart';
import 'package:getx_bloc/network/models/categories_model.dart';
import 'package:getx_bloc/screens/the_category_articles/the_category_articles.dart';
import 'package:getx_bloc/screens/the_category_articles/the_category_controller.dart';
import 'package:getx_bloc/views/category/category_slider_controller.dart';
import 'package:getx_bloc/views/the_state.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySlider extends StatefulWidget {
  final String? categoryId;

  const CategorySlider({super.key, this.categoryId});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  late CategorySliderController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put<CategorySliderController>(
      CategorySliderController(),
      // permanent: true,
      tag: widget.categoryId != null
          ? ("for_id_${widget.categoryId ?? ""}")
          : 'all',
    );
    //post frame callback

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //delay 2 seconds

      controller.getCategories(
        widget.categoryId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (ctx) {
          var model = controller.categoryModel.value;
          if (model is RxResponseError) {
            return Center(
              child: Text(
                model.error ?? "Something went wrong",
              ),
            );
          } else if (model is RxResponseSuccess<CategoryModel>) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: model.data?.data
                          ?.map(
                            (e) => GestureDetector(
                              onTap: () {
                                if (widget.categoryId != null) {
                                  PageRoutes.navigateTo(
                                    TheRoutes.categoryNSubCategoryArticles,
                                    CategoryArguments(
                                      widget.categoryId ?? "",
                                      e.id ?? "",
                                    ),
                                  );
                                  return;
                                }

                                PageRoutes.navigateTo(
                                  TheRoutes.categoryArticles,
                                  CategoryArguments(e.id ?? ""),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blueGrey,
                                ),
                                child: Text(
                                  e.name ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        });
  }
}
