import 'package:flutter/material.dart';

import '../../../config/screen_size.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/skeleton.dart';

class ExploreScreenSkeleton extends StatelessWidget {
  ExploreScreenSkeleton({Key? key}) : super(key: key);

  final screenSize = ScreenSize(width: 0, height: 0);

  @override
  Widget build(BuildContext context) {
    screenSize.width = MediaQuery.of(context).size.width;
    screenSize.height = MediaQuery.of(context).size.height;
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(height: 210, width: screenSize.width),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 120, width: 120),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 70),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 40),
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 120, width: 120),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 70),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: screenSize.width,
          child: Skeleton(
            height: 7,
            width: screenSize.width * 0.7,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Skeleton(width: 120, height: 120),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  children: [
                    const Skeleton(width: 120, height: 120),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
