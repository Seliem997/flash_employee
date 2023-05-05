class TransactionReasonsModel {
  int? statusCode;
  Null? message;
  List<ReasonData>? data;

  TransactionReasonsModel({this.statusCode, this.message, this.data});

  TransactionReasonsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReasonData>[];
      json['data'].forEach((v) {
        data!.add(new ReasonData.fromJson(v));
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

class ReasonData {
  int? id;
  String? name;
  String? createdAt;

  ReasonData({this.id, this.name, this.createdAt});

  ReasonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at '] = this.createdAt;
    return data;
  }
}
