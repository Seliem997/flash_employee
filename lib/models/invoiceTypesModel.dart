class InvoiceTypesModel {
  int? statusCode;
  Null? message;
  List<InvoiceTypeData>? data;

  InvoiceTypesModel({this.statusCode, this.message, this.data});

  InvoiceTypesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceTypeData>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceTypeData.fromJson(v));
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

class InvoiceTypeData {
  int? id;
  String? name;
  String? createdAt;
  int? amountSum;

  InvoiceTypeData({this.id, this.name, this.createdAt, this.amountSum});

  InvoiceTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at '];
    amountSum = json['amount_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at '] = this.createdAt;
    data['amount_sum'] = this.amountSum;
    return data;
  }
}
