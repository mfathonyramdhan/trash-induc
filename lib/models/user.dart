class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final double? exp;
  final double? balance;
  final String role;
  final String membership;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.exp,
    this.balance,
    this.role = "user",
    this.membership = "bronze",
  });

  User.fromJson(Map<String, dynamic> json, {String? id})
      : this(
          id: id,
          name: json["name"]! as String,
          email: json["email"]! as String,
          phone: json["phone"]! as String,
          address: json["address"]! as String,
          exp: double.tryParse(json['exp'].toString()),
          balance: double.tryParse(json['balance'].toString()),
          role: json["role"] as String? ?? "user",
          membership: json["membership"] as String? ?? "bronze",
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "exp": exp,
      "balance": balance,
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
