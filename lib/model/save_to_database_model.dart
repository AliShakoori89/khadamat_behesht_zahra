class ServicesDataBaseModel{

  ServicesDataBaseModel({
    this.id,
    this.name,
    this.description,
    this.minQty,
    this.maxQty,
    this.price,
    this.serviceId
  });

  static const String TABLENAME = "my_table";

  int? id;
  String? name;
  String? description;
  int? minQty;
  int? maxQty;
  int? price;
  int? serviceId;

  factory ServicesDataBaseModel.fromJson(Map<String, dynamic> json) => ServicesDataBaseModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    minQty: json["minQty"],
    maxQty: json["maxQty"],
    price: json["price"],
    serviceId: json['serviceId']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "minQty": minQty,
    "maxQty": maxQty,
    "price": price,
    "serviceId": serviceId
  };
}