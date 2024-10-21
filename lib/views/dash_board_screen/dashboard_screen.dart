import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';
import '../home_screen.dart';
import '../add_product/add_product_screen.dart';
import '../history_screen.dart';
import '../settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  // Screens list
  final List<Widget> selectScreen = <Widget>[
    HomeScreen(),
    AddProductScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Obx(() => selectScreen.elementAt(controller.selectedIndex.value)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        onTap: controller.onItemTapped,
        type: BottomNavigationBarType.fixed,
      )),
    );
  }
}
