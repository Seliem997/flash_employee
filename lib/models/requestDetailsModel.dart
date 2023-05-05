import 'package:flash_employee/models/requestsModel.dart';

class RequestDetailsModel {
  int? statusCode;
  String? message;
  RequestData? data;

  RequestDetailsModel({this.statusCode, this.message, this.data});

  RequestDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? RequestData.fromJson(json['data']) : null;
  }
}
