import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CouponController extends GetxController {
  // Form Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController maxDiscountController = TextEditingController();
  final TextEditingController minOrderAmountController = TextEditingController();
  final TextEditingController numCouponsController = TextEditingController();

  // Coupon type
  var selectedCouponType = ''.obs;
  var couponTypes = ['Discount %', 'Flat Discount'];

  // Dates
  var startDate = Rxn<DateTime>(); // Nullable DateTime
  var endDate = Rxn<DateTime>(); // Nullable DateTime

  // Select Date Method
  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      if (isStartDate) {
        startDate.value = pickedDate;
      } else {
        endDate.value = pickedDate;
      }
    }
  }

  // Dispose controllers
  @override
  void onClose() {
    titleController.dispose();
    codeController.dispose();
    discountController.dispose();
    maxDiscountController.dispose();
    minOrderAmountController.dispose();
    numCouponsController.dispose();
    super.onClose();
  }
}
