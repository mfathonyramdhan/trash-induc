import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/color.dart';
import '../../shared/font.dart';

class CustomDropDownField extends StatefulWidget {
  final String label;

  CustomDropDownField({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  // api provinces: http://www.emsifa.com/api-wilayah-indonesia/api/provinces.json

  List<String> provinces = [
    "Kentot",
    "kentot",
  ];

  String currentSelected = '';

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
            widget.label,
            style: regularRobotoFont.copyWith(
              fontSize: 14.sp,
              color: blackPure,
            ),
          ),
          DropdownButtonFormField(
            onChanged: (String? newValue) {
              setState(() {
                currentSelected = newValue!;
                // get data city soko api
                // https://emsifa.github.io/api-wilayah-indonesia/api/regencies/currentSelected.json
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
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
            hint: Text(
              "Pilih " + widget.label,
            ),
            items: provinces
                .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
