import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';

class UserReedemedScreen extends StatefulWidget {
  const UserReedemedScreen({Key? key}) : super(key: key);

  @override
  _UserReedemedScreenState createState() => _UserReedemedScreenState();
}

class _UserReedemedScreenState extends State<UserReedemedScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      itemCount: 2,
      itemBuilder: (context, index) => buildCard(
        "Dalam Proses",
      ),
    );
  }

  Widget buildCard(String status) {
    return Stack(children: [
      Card(
          elevation: 4,
          child: Stack(children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              height: 105.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                5.r,
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5.r,
                      ),
                      color: blackPure,
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hadiah 1",
                        style: boldRobotoFont.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          color: blackPure,
                        ),
                      ),
                      Text(
                        "Exp : 27/10/2021",
                        style: regularRobotoFont.copyWith(
                          fontSize: 11.sp,
                          color: blackPure,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(
                              color: darkGreen,
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(whitePure)),
                        onPressed: null,
                        child: Text(
                          status,
                          style: boldRobotoFont.copyWith(
                            fontSize: 13.sp,
                            color: darkGreen,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 40.w,
                height: 20.h,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          5.r,
                        ),
                        bottomLeft: Radius.circular(
                          5.r,
                        ))),
                child: Center(
                    child: Text(
                  "New",
                  style: boldRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: whitePure,
                  ),
                )),
              ),
            )
          ])),
    ]);
  }
}
