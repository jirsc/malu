import 'package:flutter/material.dart';
import 'package:malu/constants/app_constants.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton(
      {Key? key, this.height, this.width, this.cornerRadius = defaultPadding})
      : super(key: key);

  final double? height, width;
  final double cornerRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white70,
      //period: const Duration(seconds: 5),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: BoxDecoration(
            //color: Colors.black.withOpacity(0.04),
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(cornerRadius))),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
