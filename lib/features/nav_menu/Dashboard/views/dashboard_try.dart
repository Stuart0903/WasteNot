import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../redeemption/controller/redeemption_controller.dart';
import '../../qr_scanner/controller/deposit_controller.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.put(VoucherController());
  final DepositController depositController = Get.put(DepositController());
  // Sample data - replace with your actual data source
  // final int totalPoints = 2450;
  // final int plasticBottles = 78;
  // final int canBottles = 45;
  // final int glassBottles = 23;

  final List<Map<String, dynamic>> transactions = [
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'type': 'Plastic',
      'count': 5,
      'points': 25,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'type': 'Can',
      'count': 3,
      'points': 15,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'type': 'Glass',
      'count': 2,
      'points': 20,
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'type': 'Plastic',
      'count': 4,
      'points': 20,
    },
  ];

  final List<Map<String, dynamic>> partners = [
    {'name': 'Green Mart', 'logo': 'assets/greenmart.png', 'discount': '10%'},
    {'name': 'Eco Foods', 'logo': 'assets/ecofoods.png', 'discount': '15%'},
    {'name': 'Planet Cafe', 'logo': 'assets/planetcafe.png', 'discount': '20%'},
    {'name': 'Sustainable Shop', 'logo': 'assets/sustainableshop.png', 'discount': '5%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Recycle Dashboard'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh functionality
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            // Update data
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Points Card
              _buildPointsCard(),
              const SizedBox(height: 20),

              // Bottle Statistics
              _buildBottleStatisticsCard(),
              const SizedBox(height: 20),

              // Material Distribution
              _buildPieChartCard(),
              const SizedBox(height: 20),

              // Recent Transactions
              _buildRecentTransactionsCard(),
              const SizedBox(height: 20),

              // Partners
              _buildPartnersCard(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard_outlined),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.qr_code_scanner),
      //       label: 'Recycle',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.store_outlined),
      //       label: 'Rewards',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.map_outlined),
      //       label: 'Locations',
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildPointsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Points',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                //   decoration: BoxDecoration(
                //     color: Colors.green.shade100,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Row(
                //     children: const [
                //       Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                //       SizedBox(width: 4),
                //       Text(
                //         '12% this month',
                //         style: TextStyle(
                //           color: Colors.green,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 12,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${controller.currentPoints}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    'points',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 45),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: const Text('Redeem Points'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottleStatisticsCard() {
    final quantities = depositController.itemQuantities.value;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recycling Statistics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottleStatItem(
                  icon: Icons.local_drink,
                  color: Colors.blue,
                  count: quantities["plastic"]?.toString() ?? "0",
                  label: 'Plastic',
                ),
                _buildBottleStatItem(
                  icon: Icons.wine_bar,
                  color: Colors.grey,
                  count: quantities["can"]?.toString() ?? "0",
                  label: 'Can',
                ),
                _buildBottleStatItem(
                  icon: Icons.liquor,
                  color: Colors.amber,
                  count: quantities["glass"]?.toString() ?? "0",
                  label: 'Glass',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottleStatItem({
    required IconData icon,
    required Color color,
    required String count,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPieChartCard() {
    // Get quantities from the controller
    final quantities = depositController.itemQuantities.value;
    final plasticCount = quantities["plastic"] ?? 0;
    final canCount = quantities["can"] ?? 0;
    final glassCount = quantities["glass"] ?? 0;
    final totalCount = plasticCount + canCount + glassCount;

    // Calculate percentages safely (avoid division by zero)
    final plasticPercentage = totalCount > 0 ? ((plasticCount / totalCount) * 100).round() : 0;
    final canPercentage = totalCount > 0 ? ((canCount / totalCount) * 100).round() : 0;
    final glassPercentage = totalCount > 0 ? ((glassCount / totalCount) * 100).round() : 0;

    print('plastic: $plasticPercentage');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recycling by Material',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: totalCount > 0
                        ? PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            value: plasticCount.toDouble(),
                            title: '$plasticPercentage%',
                            color: Colors.blue,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: canCount.toDouble(),
                            title: '$canPercentage%',
                            color: Colors.grey,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: glassCount.toDouble(),
                            title: '$glassPercentage%',
                            color: Colors.amber,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                        : Center(
                      child: Text(
                        "No recycling data yet",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem('Plastic', Colors.blue),
                      const SizedBox(height: 12),
                      _buildLegendItem('Can', Colors.grey),
                      const SizedBox(height: 12),
                      _buildLegendItem('Glass', Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
            totalCount > 0
                ? Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                'Total Items: $totalCount',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...transactions.map((transaction) => _buildTransactionItem(transaction)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    IconData iconData;
    Color iconColor;

    switch (transaction['type']) {
      case 'Plastic':
        iconData = Icons.local_drink;
        iconColor = Colors.blue;
        break;
      case 'Can':
        iconData = Icons.wine_bar;
        iconColor = Colors.grey;
        break;
      case 'Glass':
        iconData = Icons.liquor;
        iconColor = Colors.amber;
        break;
      default:
        iconData = Icons.recycling;
        iconColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${transaction['count']} ${transaction['type']} bottles',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(transaction['date']),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+${transaction['points']} pts',
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnersCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Our Partners',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: partners.length,
                itemBuilder: (context, index) {
                  return _buildPartnerItem(partners[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerItem(Map<String, dynamic> partner) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Since we won't have actual images, using placeholder
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.store, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            partner['name'],
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}