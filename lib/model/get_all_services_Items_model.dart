class ServicesAllItemModel{

  ServicesAllItemModel({
    required this.id,
    required this.data,
    required this.success,
    required this.description,
    required this.total,
  });

  String id;
  List<DataListModel> data;
  bool success;
  String description;
  int total;

  factory ServicesAllItemModel.fromJson(Map<String, dynamic> json) => ServicesAllItemModel(
    id: json["id"],
    data: List<DataListModel>.from(json["list"].map((x) => DataListModel.fromJson(x))),
    success: json["success"],
    description: json["description"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "description": description,
    "total": total,
  };
}

class DataListModel{

  String id;
  int serviceId;
  String name;
  String code;
  int price;
  bool isDefault;
  bool transportCostIncluded;
  int qty;
  int minQty;
  int maxQty;
  String description;
  int contractorSharePercent;
  int unitMeasureId;
  String unitMeasureName;

  DataListModel({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.code,
    required this.price,
    required this.isDefault,
    required this.transportCostIncluded,
    required this.qty,
    required this.minQty,
    required this.maxQty,
    required this.description,
    required this.contractorSharePercent,
    required this.unitMeasureId,
    required this.unitMeasureName,
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