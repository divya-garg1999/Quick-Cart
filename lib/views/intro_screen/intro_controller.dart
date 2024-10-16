import 'package:get/get.dart';
import '../../models/intro_item.dart';

class IntroductionController extends GetxController {
  var currentPage = 0.obs; // Using observable for current page
  final List<IntroItem> introItems = [
    IntroItem(
      title: "Manage Your Products",
      description: "Effortlessly add, edit, and organize your products.",
      imagePath: 'assets/pic1.png',
    ),
    IntroItem(
      title: "Manage Your Stock Inventory",
      description: "Stay on top of your inventory with real-time updates.",
      imagePath: 'assets/pic2.png',
    ),
    IntroItem(
      title: "Streamline Your Billing Process",
      description: "Simplify billing with automatic tax calculations.",
      imagePath: 'assets/pic3.png',
    ),
  ];

  void nextPage() {
    if (currentPage.value < introItems.length - 1) {
      currentPage.value++;
    } else {
      Get.offAllNamed('/dashboard'); // Navigate to Dashboard
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }
}
