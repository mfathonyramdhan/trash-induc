import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiloin/models/user.dart';

class Transaction {
  final String? id;
  final User? user;
  final User? petugas;
  final Timestamp? created_at;

  Transaction({
    this.id,
    this.user,
    this.petugas,
    this.created_at,
  });

  Transaction.fromJson(Map<String, dynamic> json, {String? id})
      : this(
          id: id,
          user: User.fromJson(json["user"]),
          petugas: User.fromJson(json['petugas']),
          created_at: json["created_at"]! as Timestamp,
        );

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "petugas": petugas,
      "created_at": created_at,
    };
  }
}
