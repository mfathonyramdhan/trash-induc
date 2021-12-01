class Item {
  String? name;
  int? sell;
  int? buy;

  Item({
    this.name,
    this.buy,
    this.sell,
  });

  Item.fromJson(Map<String, Object?> json)
      : this(
          name: json["name"]! as String,
          buy: json["buy"]! as int,
          sell: json["sell"] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "buy": buy,
      "sell": sell,
    };
  }
}
