import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:getx_bloc/network/models/article_list_model.dart';
import 'package:getx_bloc/screens/the_search/the_search_controller.dart';
import 'package:getx_bloc/views/the_post_item.dart';
import 'package:getx_bloc/views/the_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class TheSearchPage extends StatefulWidget {
  const TheSearchPage({super.key});

  @override
  State<TheSearchPage> createState() => _TheSearchPageState();
}

class _TheSearchPageState extends State<TheSearchPage> {
  final controller = Get.find<SearchPageController>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0).copyWith(
                  top: 8,
                ),
                child: Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.back,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoTextField(
                        controller: controller.searchController,
                        textInputAction: TextInputAction.search,
                        // decoration: InputDecoration(
                        //   hintText: 'Search for inspiration',
                        //   hintStyle: GoogleFonts.poppins(
                        //     color: Colors.blueGrey.shade300,
                        //     fontSize: 16,
                        //   ),
                        //   border: InputBorder.none,
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: CupertinoColors.systemGrey6,
                        ),
                        onSubmitted: (value) {
                          controller.onSearch();
                        },
                        placeholder: 'Search for inspiration',
                        style: GoogleFonts.poppins(
                          color: CupertinoColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        controller.onSearch();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.search,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder(
                    init: controller,
                    builder: (context) {
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
              ),
            ],
          ),
        ),
      ),
    );

    return Container();
  }
}
