import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'billing_info_controller.dart';

class BillingInfoScreen extends StatelessWidget {
  final BillingInfoController controller = Get.put(BillingInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller.brandNameController,
              decoration: InputDecoration(labelText: 'Brand Name'),
            ),
            TextField(
              controller: controller.tagLineController,
              decoration: InputDecoration(labelText: 'Tag Line (Optional)'),
            ),
            TextField(
              controller: controller.addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: controller.contactNumberController,
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Center(
              child: Obx(() => ElevatedButton(
                onPressed: controller.submitData,
                child: Text(controller.isUpdating.value ? 'Update' : 'Add'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                ),
              )),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: controller.toggleUpdateMode,
                child: Text('Toggle Update Mode'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
