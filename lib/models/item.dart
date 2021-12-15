class Item {
  String? id;
  String? name;
  int? sell;
  int? buy;
  int? balance_point;
  int? exp_point;

  Item(
      {this.id,
      this.name,
      this.buy,
      this.sell,
      this.balance_point,
      this.exp_point});

  Item.fromJson(Map<String, dynamic> json, {String? id})
      : this(
            id: id,
            name: json["name"]! as String,
            buy: json["buy"]! as int,
            sell: json["sell"]! as int,
            balance_point: json["balance_point"]! as int,
            exp_point: json["exp_point"]! as int);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "buy": buy,
      "sell": sell,
      "balance_point": balance_point,
      "exp_point": exp_point
    };
  }
}
