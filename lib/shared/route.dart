import 'package:flutter/material.dart';
import 'package:kiloin/ui/screens/home/menu_screen.dart';

import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/home/main_screen.dart';
import '../ui/screens/wrapper.dart';

// Screen Routing List

Map<String, Widget Function(BuildContext context)> appRoute = {
  Wrapper.routeName: (BuildContext context) => Wrapper(),
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
  MainScreen.routeName: (BuildContext context) => MainScreen(),
  MenuScreen.routeName: (BuildContext context) => MenuScreen(),
};
