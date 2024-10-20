import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dash_board_screen/dashboard_screen.dart';

import 'intro_controller.dart';

class IntroductionScreen extends StatelessWidget {
  final IntroductionController controller = Get.put(IntroductionController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: screenHeight / 2 + 100,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      controller.currentPage.value = index;
                    },
                    itemCount: controller.introItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.introItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _titleWidget(item.title),
                            const SizedBox(height: 8),
                            _descriptionWidget(item.description),
                            const SizedBox(height: 20),
                            Image.asset(
                              item.imagePath,
                              width: 150,
                              height: 150,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _previousWidget(controller.currentPage),
                    if (controller.currentPage.value <
                        controller.introItems.length - 1)
                      _nextWidget("Next"),
                    if (controller.currentPage.value ==
                        controller.introItems.length - 1)
                      _nextWidget("Finish"),
                  ],
                )),
              ],
            ),
            _skipWidget(screenWidth)
          ],
        ),
      ),
    );
  }

  Widget _nextWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {
          if (title == "Next") {
            controller.nextPage();
          } else {
            Get.to(DashboardScreen()); // Navigate to DashboardScreen
          }
        },
        child: _buttonContainer(title),
      ),
    );
  }

  Widget _buttonContainer(String title) {
    return Container(
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _previousWidget(RxInt currentPage) {
    if (currentPage.value == 0) {
      return const SizedBox(width: 12);
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextButton(
          onPressed: controller.previousPage,
          child: _buttonContainer("Previous"),
        ),
      );
    }
  }

  Widget _skipWidget(double screenWidth) {
    return Positioned(
      top: 20,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
              "${controller.currentPage.value + 1}/3",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )),
            TextButton(
              onPressed: () {
                Get.to(DashboardScreen()); // Navigate to DashboardScreen
              },
              child: _buttonContainer("Skip"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: 300,
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
