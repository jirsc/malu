import 'package:doeat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:doeat/modules/modules.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          /* Stack(
            clipBehavior: Clip.none,
            children: [
              ComingBook(),
              const Positioned(
                child: CustomAppBar(),
              ),
            ],
          ), */
          Ads(),
          const SizedBox(height: 40),
          RecommendedVendor(),
          TrendingVendor(trendingList: Vendor.generateTrendingVendor()),
        ],
      ),
    );
  }
}
