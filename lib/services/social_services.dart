import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../extension/firebase_user_extension.dart';
import '../models/response_handler.dart';
import '../models/user.dart' as model;
import '../services/user_services.dart';
import '../utils/storage_util.dart';

class SocialServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<ResponseHandler> signInGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return ResponseHandler(
        success: false, 
        message: "Sign In Google Dibatalkan",
      );
    }

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential result = await _auth.signInWithCredential(credential);
    final User? user = result.user;

    model.User userConverted = result.user!.convertToUser(
      name: result.user!.displayName,
    );

    await UserServices.updateUser(userConverted);

    StorageUtil.writeStorage('social_provider', 'google');

    return ResponseHandler(
      user: user,
      success: true,
      message: "Success Google Sign In",
    );
  }

  static Future<ResponseHandler> signOutGoogle() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();

    StorageUtil.removeStorage('social_provider');

    return ResponseHandler(
      message: 'Success Google Sign Out',
    );
  }

  static Future<ResponseHandler> loginFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.webOnly,
      );

      if (loginResult.status == LoginStatus.cancelled) {
        return ResponseHandler(
          success: false,
          message: "Login Facebook Dibatalkan",
        );
      }

      if (loginResult.status == LoginStatus.failed) {
        return ResponseHandler(
          success: false,
          message: "Login Facebook Gagal",
        );
      }
      
      final AccessToken accessToken = loginResult.accessToken!;

      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

      final UserCredential result = await _auth.signInWithCredential(credential);

      final User? user = result.user;

      model.User userConverted = result.user!.convertToUser(
        name: result.user!.displayName,
      );

      await UserServices.updateUser(userConverted);

      StorageUtil.writeStorage('social_provider', 'facebook');

      return ResponseHandler(
        user: user,
        success: true,
        message: "Success Facebook Login",
      );
    } on FirebaseAuthException catch (e) {
      return ResponseHandler(
        message: e.code,
      );
    }
  }

  static Future<ResponseHandler> logoutFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();

    StorageUtil.removeStorage('social_provider');

    return ResponseHandler(
      message: 'Success Facebook Sign Out',
    );
  }
}