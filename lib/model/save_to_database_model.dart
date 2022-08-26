class ServicesDataBaseModel{

  ServicesDataBaseModel({
    this.id,
    this.name,
  });

  static const String TABLENAME = "my_table";

  int? id;
  String? name;

  factory ServicesDataBaseModel.fromJson(Map<String, dynamic> json) => ServicesDataBaseModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}