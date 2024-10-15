import 'package:flutter/material.dart';
import 'billing_info_screen.dart'; // Import the BillingInfoScreen
import 'tax_setup_screen.dart'; // Import the TaxSetupScreen
import 'coupon_screen.dart'; // Import the CouponScreen

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Billing Information
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Billing Information'),
            onTap: () {
              // Navigate to BillingInfoScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BillingInfoScreen()),
              );
            },
          ),
          Divider(),

          // Tax Setup
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Tax Setup'),
            onTap: () {
              // Navigate to TaxSetupScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TaxSetupScreen()),
              );
            },
          ),
          Divider(),

          // Report
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Report'),
            onTap: () {
              // Add navigation or action here
              print("Report tapped");
            },
          ),
          Divider(),

          // Discount Coupon
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Discount Coupon'),
            onTap: () {
              // Navigate to the CouponScreen when the coupon button is clicked
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CouponScreen()),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
