import 'package:doeat/modules/explore/explore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Ads extends StatelessWidget {
  Ads({Key? key}) : super(key: key);
  final _pageController = PageController();
  final upcomings = [
    'assets/images/ad1.jpg',
    'assets/images/ad2.jpg',
    'assets/images/ad3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PageView(
            controller: _pageController,
            children: upcomings
                .map(
                  (e) => Image.asset(
                    e,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
          ),
          Positioned(
            left: 30,
            bottom: 30,
            child: SmoothPageIndicator(
                controller: _pageController, // PageController
                count: upcomings.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotWidth: 8,
                  dotHeight: 8,
                  spacing: 4,
                  activeDotColor: Colors.white,
                ), // your preferred effect
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    curve: Curves.easeInOut,
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                  );
                }),
          ),
          const Positioned(
            bottom: -30,
            child: SearchBarButton(),
          ),
        ],
      ),
    );
  }
}
