import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/common/widgets/texts/section_heading.dart';
import 'package:wastenot/features/nav_menu/Dashboard/controllers/dashboard_controller.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/bottle_recycle_stat.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/enhanced_item_widget.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/partnerDetails.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/point_card.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/recycle_piechart_card.dart';
import 'package:wastenot/features/nav_menu/Dashboard/views/widgets/stat_item_widget.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/deposit_controller.dart';
import 'package:wastenot/features/redeemption/controller/redeemption_controller.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VoucherController());
    final DepositController depositController = Get.put(DepositController());
    final DashboardController dashboardcontroller = Get.put(DashboardController());
    final quantities = depositController.itemQuantities.value;



    return Scaffold(
      appBar: WNAppBar(
        title:  Text("WasteNot Dashboard", style: Theme.of(context).textTheme.headlineSmall),
        subtitle:  Text("Welcome Arpan Shrestha", style: Theme.of(context).textTheme.bodySmall),
        action: [
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

      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(WNSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PointCard(controller: controller),

            BottleRecyclingStat(),

            RecyclePiechart(),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(WNSizes.cardRadiusLg),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WNSectionHeading(
                      title: "Our Partners",
                      showActionButton: true,
                    ),
                    const SizedBox(height: WNSizes.spaceBtwItems),

                    Obx(() => SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dashboardcontroller.partners.length,
                        itemBuilder: (context, index) {
                          final partner = dashboardcontroller.partners[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => PartnerDetailView(partner: partner));
                              },
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    partner.companyName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ),
            )







          ],
        ),
      )

    );
  }


}






