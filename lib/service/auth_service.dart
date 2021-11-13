// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kiloin/models/auth.dart';
// import 'package:kiloin/models/response_handler.dart';
// import 'package:kiloin/models/user.dart';

// class AuthService {
//   static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   static Future signUp(Auth auth) async {
//     try {
//       UserCredential result =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: auth.email,
//         password: auth.password,
//       );
//     } on FirebaseAuthException catch (e) {
//       return ResponseHandler(
//         message: e.code,
//       );
//     }
//   }

//   static Future signIn(
//     String email,
//     String password,
//   ) async {
//     try {
//       UserCredential userCredential =
//           await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       return ResponseHandler(
//         message: e.code,
//       );
//     }
//   }

//   static Future<void> signOut() async {
//     return await _firebaseAuth.signOut();
//   }
// }
