class WarehousesModel {
  int? statusCode;
  Null? message;
  List<WarehouseData>? data;

  WarehousesModel({this.statusCode, this.message, this.data});

  WarehousesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WarehouseData>[];
      json['data'].forEach((v) {
        data!.add(new WarehouseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarehouseData {
  int? id;
  String? name;
  String? type;
  dynamic cityId;
  String? cityNameAr;
  String? cityNameEn;
  String? createdAt;

  WarehouseData(
      {this.id,
      this.name,
      this.type,
      this.cityId,
      this.cityNameAr,
      this.cityNameEn,
      this.createdAt});

  WarehouseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    cityId = json['city_id'];
    cityNameAr = json['city_name_ar'];
    cityNameEn = json['city_name_en'];
    createdAt = json['created_at '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['city_id'] = this.cityId;
    data['city_name_ar'] = this.cityNameAr;
    data['city_name_en'] = this.cityNameEn;
    data['created_at '] = this.createdAt;
    return data;
  }
}
