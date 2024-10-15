import 'package:flutter/material.dart';

class BillingInfoScreen extends StatefulWidget {
  @override
  _BillingInfoScreenState createState() => _BillingInfoScreenState();
}

class _BillingInfoScreenState extends State<BillingInfoScreen> {
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController tagLineController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isUpdating = false; // Track whether we're adding or updating

  void _submitData() {
    // You can handle your data submission here
    if (isUpdating) {
      print('Updating Billing Info:');
    } else {
      print('Adding Billing Info:');
    }

    print('Brand Name: ${brandNameController.text}');
    print('Tag Line: ${tagLineController.text}');
    print('Address: ${addressController.text}');
    print('Contact Number: ${contactNumberController.text}');
    print('Email: ${emailController.text}');

    // Optionally, clear fields after submission
    brandNameController.clear();
    tagLineController.clear();
    addressController.clear();
    contactNumberController.clear();
    emailController.clear();

    setState(() {
      isUpdating = false; // Resetting the state to add mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title removed
        backgroundColor: Colors.transparent, // Remove dark blue color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centered buttons
          children: [
            TextField(
              controller: brandNameController,
              decoration: InputDecoration(labelText: 'Brand Name'),
            ),
            TextField(
              controller: tagLineController,
              decoration: InputDecoration(labelText: 'Tag Line (Optional)'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: contactNumberController,
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Center( // Centered button
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text(isUpdating ? 'Update' : 'Add'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50), // Increased size
                  backgroundColor: Colors.blue[900], // Dark blue background
                  foregroundColor: Colors.white, // White text color
                ),
              ),
            ),
            SizedBox(height: 20),
            Center( // Centered button
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUpdating = !isUpdating; // Toggle update mode
                  });
                },
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50), // Increased size
                  backgroundColor: Colors.blue[900], // Dark blue background
                  foregroundColor: Colors.white, // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
