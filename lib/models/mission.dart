class Mission {
  String? name;
  int? balance;
  int? xp;

  Mission({
    this.name,
    this.balance,
    this.xp,
  });

  Mission.fromJson(Map<String, Object?> json)
      : this(
          name: json["name"]! as String,
          balance: json["balance"]! as int,
          xp: json["xp"] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "balance": balance,
      "xp": xp,
    };
  }
}
