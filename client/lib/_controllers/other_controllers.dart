import 'package:get/get.dart';

class OtherControllers extends GetxController {
  var isSelected = false.obs;
  var bottomIndex = 0.obs;

  static List<String> userInterests = [];

  void setNavIndex(index) {
    bottomIndex.value = index;
  }
}
