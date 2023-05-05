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
  List<Duties>? duties;

  EmployeeData(
      {this.id,
      this.fwId,
      this.username,
      this.email,
      this.phone,
      this.countryCode,
      this.image,
      this.duties});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
    if (json['duties'] != null) {
      duties = <Duties>[];
      json['duties'].forEach((v) {
        duties!.add(new Duties.fromJson(v));
      });
    }
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
    if (this.duties != null) {
      data['duties'] = this.duties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Duties {
  int? id;
  String? day;
  String? shift;
  String? startAt;
  String? endAt;
  int? employeeId;
  String? createdAt;
  String? updatedAt;

  Duties(
      {this.id,
      this.day,
      this.shift,
      this.startAt,
      this.endAt,
      this.employeeId,
      this.createdAt,
      this.updatedAt});

  Duties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    shift = json['shift'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['shift'] = this.shift;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['employee_id'] = this.employeeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
