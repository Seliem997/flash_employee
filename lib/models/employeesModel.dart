class EmployeesModel {
  int? statusCode;
  Null? message;
  List<EmployeeData>? data;

  EmployeesModel({this.statusCode, this.message, this.data});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EmployeeData>[];
      json['data'].forEach((v) {
        data!.add(new EmployeeData.fromJson(v));
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

class EmployeeData {
  int? id;
  String? fwId;
  String? username;
  String? email;
  String? phone;
  String? countryCode;
  String? image;

  EmployeeData(
      {this.id,
      this.fwId,
      this.username,
      this.email,
      this.phone,
      this.countryCode,
      this.image});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fw_id'] = this.fwId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['image'] = this.image;
    return data;
  }
}
