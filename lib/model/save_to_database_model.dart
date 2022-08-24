class ServicesDataBaseModel{

  ServicesDataBaseModel({
    this.id,
    this.name,
    this.imagePath,
  });

  static const String TABLENAME = "my_table";

  int? id;
  String? name;
  String? imagePath;

  factory ServicesDataBaseModel.fromJson(Map<String, dynamic> json) => ServicesDataBaseModel(
    id: json["id"],
    name: json["name"],
    imagePath: json["imagePath"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imagePath": imagePath,
  };
}