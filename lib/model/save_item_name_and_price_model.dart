class SaveNameAndPriceModel{

  SaveNameAndPriceModel({
    this.name,
    this.price,
  });

  static const String TABLENAME = "priceTable";

  String? name;
  int? price;

  factory SaveNameAndPriceModel.fromJson(Map<String, dynamic> json) => SaveNameAndPriceModel(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}