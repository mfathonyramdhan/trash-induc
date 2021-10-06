import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserServices {
  static CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(
      id: id,
      name: (snapshot.data() as dynamic)['name'],
      email: (snapshot.data() as dynamic)['email'],
      phone: (snapshot.data() as dynamic)['phone'],
    );
  }
  
  static Future<void> updateUser(User user) async {
   _userCollection.doc(user.id).set({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
    });
  }
}
