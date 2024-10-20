import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Reactive variable for selected index
  var selectedIndex = 0.obs;

  // Method to change the selected index
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
