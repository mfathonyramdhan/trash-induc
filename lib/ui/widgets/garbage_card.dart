import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';

class GarbageCard extends StatelessWidget {
  final String title;
  final Color textColor;

  const GarbageCard({
    this.title = "",
    this.textColor = blackPure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: whitePure,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 18.r,
            ),
            child: Image(
              height: 65.r,
              fit: BoxFit.cover,
              image: AssetImage("assets/image/bg_jual_sampah.png"),
            ),
          ),
          Container(
            width: 1.sw,
            height: 83.r,
            decoration: BoxDecoration(
              color: whitePure.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.r,
              horizontal: 18.r,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: BoxDecoration(
                        color: whitePure,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2.5.w,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      title,
                      style: mediumRobotoFont.copyWith(
                        color: textColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                generatePriceCard("Plastik", "1500"),
                generatePriceCard("Kertas", "1500"),
                generatePriceCard("Logam", "1500"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generatePriceCard(String type, String price) {
    return Column(
      children: [
        Text(
          type,
          style: boldRobotoFont.copyWith(
            color: textColor,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 18.r,
          ),
          child: Text(
            "Rp",
            textAlign: TextAlign.start,
            style: regularRobotoFont.copyWith(
              color: grayPure,
              fontSize: 12.sp,
            ),
          ),
        ),
        Text(
          price,
          style: boldRobotoFont.copyWith(
            color: blackPure,
            fontSize: 14.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 18.r,
          ),
          child: Text(
            "Kg",
            textAlign: TextAlign.start,
            style: regularRobotoFont.copyWith(
              color: grayPure,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
