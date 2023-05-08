import 'package:flash_employee/models/transactionReasonsModel.dart';

class InventoryModel {
  int? statusCode;
  Null? message;
  List<InventoryItemData>? data;

  InventoryModel({this.statusCode, this.message, this.data});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InventoryItemData>[];
      json['data'].forEach((v) {
        data!.add(new InventoryItemData.fromJson(v));
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

class InventoryItemData {
  int? id;
  String? name;
  int? quantity;
  int neededQuantity = 0;
  ReasonData? reason;
  int? price;
  int? taxId;
  Tax? tax;
  int? warehouseId;
  Warehouse? warehouse;
  int? employeeId;
  Employee? employee;
  int? countTypeId;
  CountType? countType;
  String? createdAt;
  String? updatedAt;

  InventoryItemData(
      {this.id,
      this.name,
      this.quantity,
      this.price,
      this.taxId,
      this.tax,
      this.warehouseId,
      this.warehouse,
      this.employeeId,
      this.employee,
      this.countTypeId,
      this.countType,
      this.createdAt,
      this.updatedAt});

  InventoryItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    taxId = json['tax_id'];
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    warehouseId = json['warehouse_id'];
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
    employeeId = json['employee_id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    countTypeId = json['count_type_id'];
    countType = json['count_type'] != null
        ? new CountType.fromJson(json['count_type'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['material_id'] = id;
    data['quantity'] = neededQuantity;
    data['transaction_reason_id'] = reason!.id;
    return data;
  }
}

class Tax {
  int? id;
  String? name;
  String? percent;
  int? isActive;
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

class Employee {
  int? id;
  String? fwId;
  String? username;
  String? nameEn;
  String? nameAr;
  String? email;
  String? phone;
  String? busNumber;
  int? isInventoryControl;
  int? isEditRequest;
  String? mada;
  String? stcId;
  String? countryCode;
  int? gapTime;
  String? password;
  String? position;
  Null? otp;
  String? isActive;
  Null? fcmToken;
  String? balance;
  Null? image;
  Null? emailVerifiedAt;
  Null? rememberToken;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Employee(
      {this.id,
      this.fwId,
      this.username,
      this.nameEn,
      this.nameAr,
      this.email,
      this.phone,
      this.busNumber,
      this.isInventoryControl,
      this.isEditRequest,
      this.mada,
      this.stcId,
      this.countryCode,
      this.gapTime,
      this.password,
      this.position,
      this.otp,
      this.isActive,
      this.fcmToken,
      this.balance,
      this.image,
      this.emailVerifiedAt,
      this.rememberToken,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    username = json['username'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    email = json['email'];
    phone = json['phone'];
    busNumber = json['bus_number'];
    isInventoryControl = json['is_inventory_control'];
    isEditRequest = json['is_edit_request'];
    mada = json['mada'];
    stcId = json['stc_id'];
    countryCode = json['country_code'];
    gapTime = json['gap_time'];
    password = json['password'];
    position = json['position'];
    otp = json['otp'];
    isActive = json['is_active'];
    fcmToken = json['fcm_token'];
    balance = json['balance'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    rememberToken = json['remember_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fw_id'] = this.fwId;
    data['username'] = this.username;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['bus_number'] = this.busNumber;
    data['is_inventory_control'] = this.isInventoryControl;
    data['is_edit_request'] = this.isEditRequest;
    data['mada'] = this.mada;
    data['stc_id'] = this.stcId;
    data['country_code'] = this.countryCode;
    data['gap_time'] = this.gapTime;
    data['password'] = this.password;
    data['position'] = this.position;
    data['otp'] = this.otp;
    data['is_active'] = this.isActive;
    data['fcm_token'] = this.fcmToken;
    data['balance'] = this.balance;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['deleted_at'] = this.deletedAt;
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

class Warehouse {
  int? id;
  String? name;
  String? type;
  int? cityId;
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
