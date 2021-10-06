import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'user_services.dart';
import '../extension/firebase_user_extension.dart';
import '../models/auth.dart';
import '../models/user.dart';
import '../models/response_handler.dart';
import '../utils/storage_util.dart';

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<ResponseHandler> register(Auth authData) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );

      User user = result.user!.convertToUser(
        phone: authData.phone,
      );

      await UserServices.updateUser(user);

      StorageUtil.writeStorage('social_provider', 'password');

      return ResponseHandler(user: user);
    } 
    on auth.FirebaseAuthException catch (e) {
      return ResponseHandler(
        message: e.code,
      );
    }
  }

  static Future<ResponseHandler> login(Auth authData) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );

      User user = await result.user!.fromFireStore();

      StorageUtil.writeStorage('social_provider', 'password');

      return ResponseHandler(user: user);
    } 
    on auth.FirebaseAuthException catch (e) {
      return ResponseHandler(
        message: e.code,
      );
    }
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }

  static Stream<auth.User?> get userStream => _auth.authStateChanges();
}
