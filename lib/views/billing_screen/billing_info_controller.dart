import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingInfoController extends GetxController {
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController tagLineController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  var isUpdating = false.obs; // Use obs for reactive variables

  // Method to handle data submission
  void submitData() {
    if (isUpdating.value) {
      print('Updating Billing Info:');
    } else {
      print('Adding Billing Info:');
    }

    print('Brand Name: ${brandNameController.text}');
    print('Tag Line: ${tagLineController.text}');
    print('Address: ${addressController.text}');
    print('Contact Number: ${contactNumberController.text}');
    print('Email: ${emailController.text}');

    // Clear fields after submission
    brandNameController.clear();
    tagLineController.clear();
    addressController.clear();
    contactNumberController.clear();
    emailController.clear();

    isUpdating.value = false; // Reset to add mode after submission
  }

  // Toggle update mode
  void toggleUpdateMode() {
    isUpdating.value = !isUpdating.value;
  }

  @override
  void onClose() {
    // Dispose the controllers when no longer needed
    brandNameController.dispose();
    tagLineController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
