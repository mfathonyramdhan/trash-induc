import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  String? id;
  String? name;
  int? cost;
  // ignore: non_constant_identifier_names
  Timestamp? expired_at;

  Reward({
    this.id,
    this.name,
    this.cost,
    // ignore: non_constant_identifier_names
    this.expired_at,
  });

  Reward.fromJson(Map<String, dynamic> json, {String? id})
      : this(
          id: id,
          name: json["name"]! as String,
          cost: json["cost"]! as int,
          expired_at: json["expired_at"]! as Timestamp,
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "cost": cost,
      "expired_at": expired_at,
    };
  }
}
