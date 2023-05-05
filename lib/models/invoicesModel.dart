class InvoicesModel {
  int? statusCode;
  Null? message;
  List<InvoiceData>? data;

  InvoicesModel({this.statusCode, this.message, this.data});

  InvoicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceData>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceData.fromJson(v));
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

class InvoiceData {
  int? id;
  String? image;
  int? amount;
  String? category;
  String? date;
  String? time;
  int? employeeId;
  int? invoiceTypeId;
  String? createdAt;
  InvoiceType? invoiceType;

  InvoiceData(
      {this.id,
      this.image,
      this.amount,
      this.category,
      this.date,
      this.time,
      this.employeeId,
      this.invoiceTypeId,
      this.createdAt,
      this.invoiceType});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    amount = json['amount'];
    category = json['category'];
    date = json['date'];
    time = json['time'];
    employeeId = json['employee_id '];
    invoiceTypeId = json['invoice_type_id '];
    createdAt = json['created_at '];
    invoiceType = json['invoice_type '] != null
        ? new InvoiceType.fromJson(json['invoice_type '])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['date'] = this.date;
    data['time'] = this.time;
    data['employee_id '] = this.employeeId;
    data['invoice_type_id '] = this.invoiceTypeId;
    data['created_at '] = this.createdAt;
    if (this.invoiceType != null) {
      data['invoice_type '] = this.invoiceType!.toJson();
    }
    return data;
  }
}

class InvoiceType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  InvoiceType({this.id, this.name, this.createdAt, this.updatedAt});

  InvoiceType.fromJson(Map<String, dynamic> json) {
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
