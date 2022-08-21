class ServicesAllItemModel{

  ServicesAllItemModel({
    this.id,
    this.data,
    this.success,
    this.description,
    this.total,
  });

  String? id;
  List<DataListModel>? data;
  bool? success;
  String? description;
  int? total;

  factory ServicesAllItemModel.fromJson(Map<String, dynamic> json) => ServicesAllItemModel(
    id: json["id"],
    data: List<DataListModel>.from(json["data"].map((x) => DataListModel.fromJson(x))),
    success: json["success"],
    description: json["description"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "description": description,
    "total": total,
  };
}

class DataListModel{

  String? id;
  int? serviceId;
  String? name;
  String? code;
  int? price;
  bool? isDefault;
  bool? transportCostIncluded;
  int? qty;
  int? minQty;
  int? maxQty;
  String? description;
  double? contractorSharePercent;
  int? unitMeasureId;
  String? unitMeasureName;

  DataListModel({
    this.id,
    this.serviceId,
    this.name,
    this.code,
    this.price,
    this.isDefault,
    this.transportCostIncluded,
    this.qty,
    this.minQty,
    this.maxQty,
    this.description,
    this.contractorSharePercent,
    this.unitMeasureId,
    this.unitMeasureName,
  });

  factory DataListModel.fromJson(Map<String, dynamic> json) => DataListModel(
    id: json["id"],
    serviceId: json["serviceId"],
    name: json["name"],
    code: json["code"],
    price: json["price"],
    isDefault: json["isDefault"],
    transportCostIncluded: json["transportCostIncluded"],
    qty: json["qty"],
    minQty: json["minQty"],
    maxQty: json["maxQty"],
    description: json["description"],
    contractorSharePercent: json["contractorSharePercent"],
    unitMeasureId: json["unitMeasureId"],
    unitMeasureName: json["unitMeasureName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceId": serviceId,
    "name": name,
    "code": code,
    "price": price,
    "isDefault": isDefault,
    "transportCostIncluded": transportCostIncluded,
    "qty": qty,
    "minQty": minQty,
    "maxQty": maxQty,
    "description": description,
    "contractorSharePercent": contractorSharePercent,
    "unitMeasureId": unitMeasureId,
    "unitMeasureName": unitMeasureName,
  };
}