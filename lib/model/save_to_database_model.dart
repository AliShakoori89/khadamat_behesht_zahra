class SaveToDataBaseModel{

  SaveToDataBaseModel({
    this.id,
    this.name,
    this.imagePath,
  });

  static const String TABLENAME = "my_table";

  String? id;
  String? name;
  String? imagePath;

  factory SaveToDataBaseModel.fromJson(Map<String, dynamic> json) => SaveToDataBaseModel(
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