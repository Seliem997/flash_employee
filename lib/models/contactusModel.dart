import 'loginModel.dart';

class ContactUsModel {
  int? statusCode;
  Null? message;
  List<ContactData>? data;

  ContactUsModel({this.statusCode, this.message, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContactData>[];
      json['data'].forEach((v) {
        data!.add(new ContactData.fromJson(v));
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

class ContactData {
  int? id;
  String? fwId;
  String? username;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  List<Duties>? duties;

  ContactData(
      {this.id,
        this.fwId,
        this.username,
        this.email,
        this.phone,
        this.countryCode,
        this.image,
        this.duties});

  ContactData.fromJson(Map<String, dynamic> json) {
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
