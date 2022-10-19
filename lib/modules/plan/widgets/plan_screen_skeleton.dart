import 'package:flutter/material.dart';
import 'package:malu/constants/app_constants.dart';

import '../../../config/screen_size.dart';
import '../../../widgets/skeleton.dart';

class PlanScreenSkeleton extends StatelessWidget {
  PlanScreenSkeleton({Key? key}) : super(key: key);

  final screenSize = ScreenSize(width: 0, height: 0);

  @override
  Widget build(BuildContext context) {
    screenSize.width = MediaQuery.of(context).size.width;
    screenSize.height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Meal Plan",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              Skeleton(height: 70, width: screenSize.width, cornerRadius: 7),
              const SizedBox(height: 12),
              Skeleton(height: 20, width: screenSize.width, cornerRadius: 4),
              const SizedBox(height: 7),
              Skeleton(height: 40, width: screenSize.width, cornerRadius: 7),
              const SizedBox(height: 7),
              const Divider(thickness: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(4, (index) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Skeleton(height: 130, width: 130),
                            SizedBox(height: 4),
                            Skeleton(height: 7, width: 70),
                            SizedBox(height: 4),
                            Skeleton(height: 7, width: 40),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
