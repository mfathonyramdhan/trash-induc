import 'package:flutter/material.dart';
import 'package:kiloin/ui/screens/user/chat/user_chat_screen.dart';
import 'package:kiloin/ui/screens/user/home/user_main_screen.dart';
import 'package:kiloin/ui/screens/user/home/user_menu_screen.dart';
import 'package:kiloin/ui/screens/user/profile/user_edit_profile_screen.dart';
import 'package:kiloin/ui/screens/user/profile/user_profile_screen.dart';
import 'package:kiloin/ui/screens/user/reedem/user_reedem_screen.dart';
import 'package:kiloin/ui/screens/user/transaction/user_transaction_screen.dart';

import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/wrapper.dart';

// Screen Routing List

Map<String, Widget Function(BuildContext context)> appRoute = {
  Wrapper.routeName: (BuildContext context) => Wrapper(),
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
  MainScreen.routeName: (BuildContext context) => MainScreen(),
  UserMenuScreen.routeName: (BuildContext context) => UserMenuScreen(),
  UserTransactionScreen.routeName: (BuildContext context) =>
      UserTransactionScreen(),
  UserChatScreen.routeName: (BuildContext context) => UserChatScreen(),
  UserProfileScreen.routeName: (BuildContext context) => UserProfileScreen(),
  UserReedemScreen.routeName: (BuildContext context) => UserReedemScreen(),
  UserEditProfileScreen.routeName: (BuildContext context) =>
      UserEditProfileScreen(),
};
