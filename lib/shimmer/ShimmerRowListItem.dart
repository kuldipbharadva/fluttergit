import 'package:flutter/material.dart';
import 'package:flutter_learn_app/custom_widgets/CardView.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';

class ShimmerRowListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: CardView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SizedBox(height: 50)],
          ),
        ),
      ),
    );
  }
}
