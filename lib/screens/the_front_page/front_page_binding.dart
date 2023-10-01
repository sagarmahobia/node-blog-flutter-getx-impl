import 'package:get/get.dart';
import 'package:getx_bloc/screens/the_front_page/front_page_controller.dart';
import 'package:getx_bloc/views/category/category_slider_controller.dart';

class FrontPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FrontPageController>(FrontPageController());
  }
}
