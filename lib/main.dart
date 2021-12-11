import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/repository/admin_drawer_repository.dart';
import 'package:kiloin/repository/cart_item_repository.dart';
import 'package:kiloin/repository/officer_drawer_repository.dart';
import 'package:kiloin/utils/firebase_utils.dart';
import 'package:provider/provider.dart';

import 'shared/route.dart';
import 'shared/theme.dart';
import 'ui/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: FirebaseUtils.userStream,
          initialData: "",
        ),
        ChangeNotifierProvider(
          create: (_) => CartItemRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminDrawerRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => OfficerDrawerRepository(),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 640),
        builder: () => MaterialApp(
          title: 'Bank Sampah App',
          routes: appRoute,
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}
