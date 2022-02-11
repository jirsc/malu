import 'package:doeat/utils/utils.dart';
import 'package:flutter/material.dart';

class VendorScreenHeader extends StatefulWidget {
  const VendorScreenHeader({Key? key}) : super(key: key);

  @override
  State<VendorScreenHeader> createState() => _VendorScreenHeaderState();
}

class _VendorScreenHeaderState extends State<VendorScreenHeader> {
  bool isSavedToFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ad2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesome4.angle_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: isSavedToFavorites
                            ? const Icon(
                                FontAwesome4.heart,
                                color: Colors.red,
                                size: 20,
                              )
                            : const Icon(
                                FontAwesome4.heart_empty,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                      onTap: () => setState(() {
                        isSavedToFavorites = !isSavedToFavorites;
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesome4.user_plus,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
