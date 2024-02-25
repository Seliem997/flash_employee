class TransactionsModel {
  int? statusCode;
  Null? message;
  List<TransactionData>? data;

  TransactionsModel({this.statusCode, this.message, this.data});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
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

class TransactionData {
  int? id;
  String? type;
  dynamic employeeId;
  dynamic employeeIdTo;
  dynamic warehouseId;
  String? createdAt;
  Warehouse? warehouse;
  List<TransactionMaterials>? transactionMaterials;
  EmployeeTo? employeeFrom;
  EmployeeTo? employeeTo;

  TransactionData(
      {this.id,
      this.type,
      this.employeeId,
      this.employeeIdTo,
      this.warehouseId,
      this.createdAt,
      this.warehouse,
      this.transactionMaterials,
      this.employeeFrom,
      this.employeeTo});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    employeeId = json['employee_id'];
    employeeIdTo = json['employee_id_to'];
    warehouseId = json['warehouse_id'];
    createdAt = json['created_at'];
    warehouse = json['warehouse'] != null
        ? new Warehouse.fromJson(json['warehouse'])
        : null;
    if (json['transactionMaterials'] != null) {
      transactionMaterials = <TransactionMaterials>[];
      json['transactionMaterials'].forEach((v) {
        transactionMaterials!.add(new TransactionMaterials.fromJson(v));
      });
    }
    employeeFrom = json['employee_from'] != null
        ? new EmployeeTo.fromJson(json['employee_from'])
        : null;
    employeeTo = json['employee_to'] != null
        ? new EmployeeTo.fromJson(json['employee_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['employee_id'] = this.employeeId;
    data['employee_id_to'] = this.employeeIdTo;
    data['warehouse_id'] = this.warehouseId;
    data['created_at'] = this.createdAt;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    if (this.transactionMaterials != null) {
      data['transactionMaterials'] =
          this.transactionMaterials!.map((v) => v.toJson()).toList();
    }
    data['employee_from'] = this.employeeFrom;
    return data;
  }
}

class Warehouse {
  int? id;
  String? name;
  String? type;
  dynamic cityId;
  String? createdAt;
  String? updatedAt;

  Warehouse(
      {this.id,
      this.name,
      this.type,
      this.cityId,
      this.createdAt,
      this.updatedAt});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TransactionMaterials {
  int? id;
  dynamic quantity;
  dynamic materialId;
  String? materialName;
  String? materialCountTypeName;
  dynamic transactionReasonId;
  String? transactionReasonName;
  String? createdAt;
  String? updatedAt;
  Material? material;

  TransactionMaterials(
      {this.id,
      this.quantity,
      this.materialId,
      this.materialName,
      this.materialCountTypeName,
      this.transactionReasonId,
      this.transactionReasonName,
      this.createdAt,
      this.updatedAt,
      this.material});

  TransactionMaterials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    materialCountTypeName = json['material_count_type_name'];
    transactionReasonId = json['transaction_reason_id'];
    transactionReasonName = json['transactionReason_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    material = json['material'] != null
        ? new Material.fromJson(json['material'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['material_id'] = this.materialId;
    data['material_name'] = this.materialName;
    data['material_count_type_name'] = this.materialCountTypeName;
    data['transaction_reason_id'] = this.transactionReasonId;
    data['transactionReason_name'] = this.transactionReasonName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.material != null) {
      data['material'] = this.material!.toJson();
    }
    return data;
  }
}

class Material {
  int? id;
  String? name;
  dynamic quantity;
  dynamic price;
  dynamic taxId;
  Tax? tax;
  dynamic warehouseId;
  Warehouse? warehouse;
  dynamic employeeId;
  dynamic countTypeId;
  CountType? countType;
  String? createdAt;
  String? updatedAt;

  Material(
      {this.id,
      this.name,
      this.quantity,
      this.price,
      this.taxId,
      this.tax,
      this.warehouseId,
      this.warehouse,
      this.employeeId,
      this.countTypeId,
      this.countType,
      this.createdAt,
      this.updatedAt});

  Material.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    taxId = json['tax_id'];
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    warehouseId = json['warehouse_id'];
    warehouse = json['warehouse'] != null
        ? new Warehouse.fromJson(json['warehouse'])
        : null;
    employeeId = json['employee_id'];
    countTypeId = json['count_type_id'];
    countType = json['count_type'] != null
        ? new CountType.fromJson(json['count_type'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['tax_id'] = this.taxId;
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    data['warehouse_id'] = this.warehouseId;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    data['employee_id'] = this.employeeId;
    data['count_type_id'] = this.countTypeId;
    if (this.countType != null) {
      data['count_type'] = this.countType!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Tax {
  int? id;
  String? name;
  String? percent;
  dynamic isActive;
  String? createdAt;
  String? updatedAt;

  Tax(
      {this.id,
      this.name,
      this.percent,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Tax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percent = json['percent'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percent'] = this.percent;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CountType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CountType({this.id, this.name, this.createdAt, this.updatedAt});

  CountType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class EmployeeTo {
  int? id;
  String? fwId;
  String? username;
  String? email;
  String? phone;
  String? countryCode;
  String? image;

  EmployeeTo(
      {this.id,
      this.fwId,
      this.username,
      this.email,
      this.phone,
      this.countryCode,
      this.image});

  EmployeeTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
  }
}
