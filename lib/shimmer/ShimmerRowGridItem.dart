import 'package:flutter/material.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';

class ShimmerRowGridItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.shimmerColor),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.shimmerColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.shimmerColor),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
