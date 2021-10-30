import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class CustomTextForm extends StatelessWidget {
  final String label;
  final bool? readOnly;
  final TextInputType keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;

  CustomTextForm({
    Key? key,
    required this.label,
    this.readOnly = false,
    required this.keyboardType,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 10.w,
        right: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: regularRobotoFont.copyWith(
              fontSize: 14.sp,
              color: blackPure,
            ),
          ),
          TextFormField(
            minLines: 1,
            maxLines: 2,
            // initialValue: init,
            style: TextStyle(
              fontSize: 16.sp,
            ),
            readOnly: readOnly!,
            keyboardType: keyboardType,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.r,
                    ),
                    borderSide: BorderSide(
                      width: 2,
                      color: grayPure,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.r,
                    ),
                    borderSide: BorderSide(
                      width: 2,
                      color: lightGreen,
                    ))),
          ),
        ],
      ),
    );
  }
}
