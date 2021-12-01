class User {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final int? expPoint;
  final int? balancePoint;
  final String role;
  final String membership;

  User({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.expPoint,
    this.balancePoint,
    this.role = "user",
    this.membership = "bronze",
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          name: json["name"]! as String,
          email: json["email"]! as String,
          phone: json["phone"]! as String,
          address: json["address"]! as String,
          expPoint: json["expPoint"]! as int,
          balancePoint: json["balancePoint"]! as int,
          role: json["role"] as String? ?? "user",
          membership: json["membership"] as String? ?? "bronze",
        );

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "expPoint": expPoint,
      "balancePoint": balancePoint,
      "role": role,
      "membership": membership
    };
  }

  static converter() {
    return {
      'fromFirestore': (snapshot, _) => User.fromJson(snapshot.data()!),
      'toFirestore': (user, _) => user.toJson()
    };
  }
}
