import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCommonListView extends StatelessWidget {
  final Widget child;
  final int count;

  const ShimmerCommonListView({Key key, this.child, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Colors.grey[200],
      enabled: true,
      child: ListView.builder(
          itemCount: count,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return child;
          }),
    );
  }
}
