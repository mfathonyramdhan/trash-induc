import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiloin/models/user.dart';

class Transaction {
  String? id;
  User? user;
  User? petugas;
  // ignore: non_constant_identifier_names
  Timestamp? created_at;
  double? total;

  Transaction({
    this.id,
    this.user,
    this.petugas,
    // ignore: non_constant_identifier_names
    this.created_at,
    this.total,
  });

  Transaction.fromJson(Map<String, dynamic> json, {String? id})
      : this(
          id: id,
          user: User.fromJson(json["user"]),
          petugas: User.fromJson(json['petugas']),
          created_at: json["created_at"]! as Timestamp,
          total: json["total"]! as double,
        );

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "petugas": petugas,
      "created_at": created_at,
      "total": total,
    };
  }
}
