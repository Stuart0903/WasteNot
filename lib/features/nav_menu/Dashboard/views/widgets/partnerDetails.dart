import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/nav_menu/Dashboard/model/partner_model.dart';

class PartnerDetailView extends StatelessWidget {
  final PartnerModel partner;

  const PartnerDetailView({super.key, required this.partner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(partner.companyName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company Name: ${partner.companyName}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Address: ${partner.address}'),
            const SizedBox(height: 8),
            Text('Contact Email: ${partner.contactEmail}'),
            const SizedBox(height: 8),
            Text('Contact Number: ${partner.contactNo}'),
            const SizedBox(height: 8),
            Text('Partnership Since: ${partner.partnershipSince}'),
            const SizedBox(height: 8),
            Text('Status: ${partner.isActive ? 'Active' : 'Inactive'}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}