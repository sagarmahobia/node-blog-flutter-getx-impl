import 'package:get/get.dart';
import 'package:getx_bloc/screens/the_front_page/front_page_controller.dart';
import 'package:getx_bloc/screens/the_search/the_search_controller.dart';
import 'package:getx_bloc/views/category/category_slider_controller.dart';

class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchPageController>(SearchPageController());
  }
}
