import 'package:flutter/material.dart';
import 'package:kiloin/ui/screens/user/chat/chat_screen.dart';
import 'package:kiloin/ui/screens/user/home/main_screen.dart';
import 'package:kiloin/ui/screens/user/home/menu_screen.dart';
import 'package:kiloin/ui/screens/user/profile/edit_screen.dart';
import 'package:kiloin/ui/screens/user/profile/profile_screen.dart';
import 'package:kiloin/ui/screens/user/reedem/reedem_screen.dart';
import 'package:kiloin/ui/screens/user/transaction/transaction_screen.dart';

import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/wrapper.dart';

// Screen Routing List

Map<String, Widget Function(BuildContext context)> appRoute = {
  Wrapper.routeName: (BuildContext context) => Wrapper(),
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
  MainScreen.routeName: (BuildContext context) => MainScreen(),
  MenuScreen.routeName: (BuildContext context) => MenuScreen(),
  TransactionScreen.routeName: (BuildContext context) => TransactionScreen(),
  ChatScreen.routeName: (BuildContext context) => ChatScreen(),
  ProfileScreen.routeName: (BuildContext context) => ProfileScreen(),
  ReedemScreen.routeName: (BuildContext context) => ReedemScreen(),
  EditProfileScreen.routeName: (BuildContext context) => EditProfileScreen(),
};
