import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiloin/shared/size.dart';

class FirebaseUtils {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static User? currentUser = auth.currentUser;

  static Future setupUser(String email, String phoneNumber) async {
    String uid = currentUser!.uid.toString();

    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(uid);

    await userRef.set({
      "name": "-",
      "email": email,
      "phone": phoneNumber,
      "address": "-",
      "expPoint": 0,
      "balancePoint": 0,
      "role": "user",
      "membership": "bronze"
    });
    return;
  }

  static Future setupUserForGoogle() async {
    String uid = currentUser!.uid.toString();

    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(uid);

    await userRef.set({
      "name": "-",
      "email": "-",
      "phone": "-",
      "address": "-",
      "expPoint": 0,
      "balancePoint": 0,
      "role": "user",
      "membership": "bronze"
    });
    return;
  }

  static Future signOut() async {
    // check what login method
    var loginProvider = currentUser!.providerData[0].providerId;

    if (loginProvider == "password") {
      await auth.signOut();
    } else if (loginProvider == "google.com") {
      await googleSignIn.signOut();
      await auth.signOut();
    }
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Stream<User?> get userStream => auth.authStateChanges();
}