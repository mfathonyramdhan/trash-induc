// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kiloin/repository/account_repository.dart';
// import 'package:kiloin/shared/color.dart';
// import 'package:kiloin/shared/font.dart';
// import 'package:provider/provider.dart';

// class AdminAddAccountScreen extends StatefulWidget {
//   const AdminAddAccountScreen({Key? key}) : super(key: key);
//   static String routeName = "/admin_add_account";

//   @override
//   _AdminAddAccountScreenState createState() => _AdminAddAccountScreenState();
// }

// class _AdminAddAccountScreenState extends State<AdminAddAccountScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: darkGreen,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//             )),
//         title: Text(
//           "Tambah Akun",
//           style: boldRobotoFont.copyWith(
//             fontSize: 18.sp,
//           ),
//         ),
//         titleSpacing: 0,
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           Form(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Nama"),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   hintText: "Contoh: Adi",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                     8.r,
//                   )),
//                   isDense: true,
//                 ),
//               ),
//               Text("Email"),
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   hintText: "Contoh: adi@gmail.com",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                     8.r,
//                   )),
//                   isDense: true,
//                 ),
//               ),
//               Text("Phone"),
//               TextFormField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Contoh: 081212121212(12 digit)",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                     8.r,
//                   )),
//                   isDense: true,
//                 ),
//               ),
//               Text("Password"),
//               TextFormField(
//                 controller: passwordController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                     8.r,
//                   )),
//                   isDense: true,
//                 ),
//               ),
//               Consumer(
//                 builder: (context, value, child) {
//                   final repository = Provider.of<AccountRepository>(
//                     context,
//                   );
//                   return ListTile(
//                     leading: Checkbox(
//                       value: repository.isAdminChecked,
//                       onChanged: (bool) {
//                         repository.setCheckBox(bool!);
//                       },
//                     ),
//                     title: Text(
//                       "Apakah admin?",
//                     ),
//                   );
//                 },
//               ),
//             ],
//           )),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: darkGreen,
//             ),
//             onPressed: () async {
//               // await submitData();
//             },
//             child: Text("Buat akun"),
//           )
//         ],
//       ),
//     );
//   }

//   // Future submitData() async {
//   //   final repository = Provider.of<AccountRepository>(
//   //     context,
//   //     listen: false,
//   //   );

//   //   String name = nameController.text;
//   //   String email = emailController.text;
//   //   String phone = phoneController.text;
//   //   String password = passwordController.text;

//   //   UserCredential userCredential =
//   //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//   //     email: email,
//   //     password: password,
//   //   );

//   //   DocumentReference reference = FirebaseFirestore.instance
//   //       .collection("users")
//   //       .doc(userCredential.user!.uid);

//   //   await reference.set({
//   //     "name": name,
//   //     "email": email,
//   //     "phone": phone,
//   //     "address": "",
//   //     "exp": 0,
//   //     "balance": 0,
//   //     "role": repository.isAdminChecked ? "petugas" : "user",
//   //     "membership": "bronze",
//   //     "photoUrl": ""
//   //   });
//   //   return;
//   // }
// }
