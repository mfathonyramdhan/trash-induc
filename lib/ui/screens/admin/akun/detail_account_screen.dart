import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/user.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminDetailAccountScreen extends StatefulWidget {
  const AdminDetailAccountScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  _AdminDetailAccountScreenState createState() =>
      _AdminDetailAccountScreenState();
}

class _AdminDetailAccountScreenState extends State<AdminDetailAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Detail Akun",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          widget.user.photoUrl == ""
              ? Center(
                  child: Text("Tidak ada foto"),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.photoUrl!),
                ),
          Text("Nama"),
          TextFormField(
            initialValue: widget.user.name,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
          Text("Email"),
          TextFormField(
            initialValue: widget.user.email,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
          Text("Phone"),
          TextFormField(
            initialValue:
                widget.user.phone == "" ? "Belum diisi" : widget.user.phone,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
          Text("Balance"),
          TextFormField(
            initialValue: widget.user.balance.toString(),
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
          Text("Exp"),
          TextFormField(
            initialValue: widget.user.exp.toString(),
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
          Text("Membership"),
          TextFormField(
            initialValue: widget.user.membership,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
          Text("Role"),
          TextFormField(
            initialValue: widget.user.role,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                8.r,
              )),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
