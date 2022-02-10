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
                  /* Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        e,
                        fit: BoxFit.cover,
                      ), */
                  /* Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 1,
                        ),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Colors.black,
                              Colors.black45,
                              Colors.black12,
                              Colors.black.withAlpha(0),
                            ],
                          ),
                        ),
                      ), 
                      const Positioned(
                        top: 20,
                        left: 30,
                        child: Text(
                          'Upcoming Book',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 55,
                        left: 30,
                        child: Text(
                          '30+ new books coming with various\ngames are waiting for you',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ), 
                    ],
                  ),*/
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
