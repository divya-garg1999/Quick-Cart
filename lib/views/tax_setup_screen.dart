import 'package:flutter/material.dart';

class TaxSetupScreen extends StatefulWidget {
  @override
  _TaxSetupScreenState createState() => _TaxSetupScreenState();
}

class _TaxSetupScreenState extends State<TaxSetupScreen> {
  bool _isTaxExcluded = false; // Switch state
  final TextEditingController _taxPercentageController = TextEditingController();

  void _submitTaxSetup() {
    final String taxPercentageText = _taxPercentageController.text.trim();
    final double? taxPercentage = double.tryParse(taxPercentageText);

    if (taxPercentage == null && _isTaxExcluded) {
      // Show error if the tax percentage is required but not provided
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid tax percentage')),
      );
      return;
    }

    // Print or process the tax setup
    print('Tax Excluded: $_isTaxExcluded');
    if (_isTaxExcluded) {
      print('Tax Percentage: $taxPercentage%');
    }

    // Clear the text field
    _taxPercentageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tax Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_isTaxExcluded ? 'Exclude Tax' : 'Include Tax'),
                Switch(
                  value: _isTaxExcluded,
                  onChanged: (value) {
                    setState(() {
                      _isTaxExcluded = value; // Update the switch state
                    });
                  },
                  activeColor: Colors.blue[900], // Dark blue color when active
                ),
              ],
            ),
            if (_isTaxExcluded) ...[
              SizedBox(height: 20),
              Text('Tax Percentage:'),
              SizedBox(height: 8),
              TextField(
                controller: _taxPercentageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter tax percentage',
                ),
              ),
            ],
            SizedBox(height: 20),
            Center( // Centering the submit button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Dark blue background
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: _submitTaxSetup,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
