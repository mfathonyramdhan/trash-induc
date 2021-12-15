class Mission {
  String? id;
  String? name;
  int? balance;
  int? exp;
  // ignore: non_constant_identifier_names
  bool? is_active;

  Mission({
    this.id,
    this.name,
    this.balance,
    this.exp,
    // ignore: non_constant_identifier_names
    this.is_active,
  });

  Mission.fromJson(Map<String, Object?> json, {String? id})
      : this(
          id: id,
          name: json["name"]! as String,
          balance: json["balance"]! as int,
          exp: json["exp"] as int,
          is_active: json["is_active"] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "balance": balance,
      "exp": exp,
      "is_active": is_active,
    };
  }
}
