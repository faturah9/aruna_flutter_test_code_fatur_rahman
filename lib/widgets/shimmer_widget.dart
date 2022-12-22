import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder? shape;
  ShimmerWidget.rectangle({
    Key? key,
    this.width,
    this.height,
  })  : shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey,
      ),
    );
  }
}
