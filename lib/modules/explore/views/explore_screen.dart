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
          Stack(children: [
            Column(
              children: [
                Ads(),
                const SizedBox(height: 40),
                RecommendedVendor(),
              ],
            ),
            const Positioned(
              top: 140,
              child: SearchBarButton(),
            ),
          ]),
          TrendingVendor(trendingList: Vendor.generateTrendingVendor()),
        ],
      ),
    );
  }
}
