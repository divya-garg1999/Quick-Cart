import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'coupon_controller.dart';

class CouponScreen extends StatelessWidget {
  final CouponController controller = Get.put(CouponController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Coupon'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Code
            TextField(
              controller: controller.codeController,
              decoration: InputDecoration(
                labelText: 'Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Coupon Type Dropdown
            Obx(() => DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              value: controller.selectedCouponType.value.isEmpty
                  ? null
                  : controller.selectedCouponType.value,
              onChanged: (String? newValue) {
                controller.selectedCouponType.value = newValue!;
              },
              items: controller.couponTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
            SizedBox(height: 16),

            // Discount
            TextField(
              controller: controller.discountController,
              decoration: InputDecoration(
                labelText: 'Discount Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Max Discount (optional)
            TextField(
              controller: controller.maxDiscountController,
              decoration: InputDecoration(
                labelText: 'Max Discount (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Minimum Order Amount (optional)
            TextField(
              controller: controller.minOrderAmountController,
              decoration: InputDecoration(
                labelText: 'Minimum Order Amount (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Start Date (optional)
            Obx(() => TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Date (Optional)',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () => controller.selectDate(context, true),
              controller: TextEditingController(
                text: controller.startDate.value != null
                    ? DateFormat('yyyy-MM-dd').format(controller.startDate.value!)
                    : '',
              ),
            )),
            SizedBox(height: 16),

            // End Date (optional)
            Obx(() => TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'End Date (Optional)',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () => controller.selectDate(context, false),
              controller: TextEditingController(
                text: controller.endDate.value != null
                    ? DateFormat('yyyy-MM-dd').format(controller.endDate.value!)
                    : '',
              ),
            )),
            SizedBox(height: 16),

            // Number of Coupons (optional)
            TextField(
              controller: controller.numCouponsController,
              decoration: InputDecoration(
                labelText: 'Number of Coupons (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),

            // View Coupon Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], // Dark blue background
                  foregroundColor: Colors.white, // White text color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  // Handle coupon submission logic here
                  print("View Coupons or Add Coupon logic.");
                },
                child: Text('View Coupons'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
