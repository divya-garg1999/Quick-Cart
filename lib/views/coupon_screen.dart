import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController maxDiscountController = TextEditingController();
  final TextEditingController minOrderAmountController = TextEditingController();
  final TextEditingController numCouponsController = TextEditingController();

  String? selectedCouponType;
  DateTime? startDate;
  DateTime? endDate;

  List<String> couponTypes = ['Discount %', 'Flat Discount'];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != (isStartDate ? startDate : endDate)) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

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
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Code
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Coupon Type Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              value: selectedCouponType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCouponType = newValue;
                });
              },
              items: couponTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Discount
            TextField(
              controller: discountController,
              decoration: InputDecoration(
                labelText: 'Discount Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Max Discount (optional)
            TextField(
              controller: maxDiscountController,
              decoration: InputDecoration(
                labelText: 'Max Discount (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Minimum Order Amount (optional)
            TextField(
              controller: minOrderAmountController,
              decoration: InputDecoration(
                labelText: 'Minimum Order Amount (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Start Date (optional)
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Date (Optional)',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectDate(context, true),
              controller: TextEditingController(
                text: startDate != null
                    ? DateFormat('yyyy-MM-dd').format(startDate!)
                    : '',
              ),
            ),
            SizedBox(height: 16),

            // End Date (optional)
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'End Date (Optional)',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectDate(context, false),
              controller: TextEditingController(
                text: endDate != null
                    ? DateFormat('yyyy-MM-dd').format(endDate!)
                    : '',
              ),
            ),
            SizedBox(height: 16),

            // Number of Coupons (optional)
            TextField(
              controller: numCouponsController,
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
