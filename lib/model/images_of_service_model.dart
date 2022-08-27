import 'dart:ui';

class ImagesOfServiceModel{

  ImagesOfServiceModel({
    this.id,
    this.data,
    this.success,
    this.description,
    this.total,
  });

  String? id;
  List<DataListOfImagesModel>? data;
  bool? success;
  String? description;
  int? total;

  factory ImagesOfServiceModel.fromJson(Map<String, dynamic> json) => ImagesOfServiceModel(
    id: json["\$id"],
    data: List<DataListOfImagesModel>.from(json["data"].map((x) => DataListOfImagesModel.fromJson(x))),
    success: json["success"],
    description: json["description"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "\$id": id,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "description": description,
    "total": total,
  };
}

class DataListOfImagesModel{

  String? id;
  int? serviceImageId;
  bool? isDefault;
  int? serviceId;
  int? imageId;
  Image? image;

  DataListOfImagesModel({
    this.id,
    this.serviceImageId,
    this.isDefault,
    this.serviceId,
    this.imageId,
    this.image
  });

  factory DataListOfImagesModel.fromJson(Map<String, dynamic> json) => DataListOfImagesModel(
    id: json["\$id"],
    serviceImageId: json['serviceImageId'],
    isDefault: json['isDefault'],
    serviceId: json["serviceId"],
    imageId: json["imageId"],
    image: Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "\$id": id,
    "serviceImageId": serviceImageId,
    "isDefault": isDefault,
    "serviceId": serviceId,
    "imageId": imageId,
    "image": image!.toJson(),
  };
}

class Image {
  Image({
    this.id,
    this.fileId,
    this.fileName,
    this.fileExtention,
    this.fileLength,
  });

  String? id;
  int? fileId;
  String? fileName;
  String? fileExtention;
  int? fileLength;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    fileId: json["fileId"],
    fileName: json["fileName"],
    fileExtention: json["fileExtention"],
    fileLength: json["fileLength"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileId": fileId,
    "fileName": fileName,
    "fileExtention": fileExtention,
    "fileLength": fileLength,
  };
}