import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';
import '../services/user_services.dart';

extension FirebaseUserExtension on auth.User {
  User convertToUser({String? name = "-", String? phone = "-"}) {
    return User(
      id: this.uid,
      email: this.email,
      name: name,
      phone: phone,
    );
  }

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
