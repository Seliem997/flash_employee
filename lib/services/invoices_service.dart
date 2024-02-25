import 'dart:developer';
import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/models/profileModel.dart';

import '../base/service/base_service.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';

class InvoicesService extends BaseService {
  Future<ResponseResult> getInvoices(
      {String invoiceId = "", String category = "", String date = ""}) async {
    Status status = Status.error;
    List<InvoiceData>? invoices;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getInvoices(
            date: date,
            invoiceId: invoiceId,
            category: category,
          ),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              invoices = InvoicesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting invoices $e");
    }
    return ResponseResult(status, invoices);
  }

  Future<ResponseResult> getInvoicesSum({String date = ""}) async {
    Status status = Status.error;
    List<InvoiceTypeData>? invoices;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getInvoicesSum(date: date,),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              invoices = InvoiceTypesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting invoices $e");
    }
    return ResponseResult(status, invoices);
  }

  Future<ResponseResult> getInvoicesTypes() async {
    Status status = Status.error;
    List<InvoiceTypeData>? invoices;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getInvoiceTypes,
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              invoices = InvoiceTypesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting invoices $e");
    }
    return ResponseResult(status, invoices);
  }

  Future<ResponseResult> addInvoice({
    required String date,
    required String time,
    required String invoiceTypeId,
    required String amount,
  }) async {
    Status status = Status.error;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    Map<String, dynamic> body = {
      "amount": amount,
      "date": date,
      "time": time,
      "invoice_type_id": invoiceTypeId,
      "image": "mmm",
    };

    try {
      await requestFutureData(
          api: Api.addInvoice,
          body: body,
          headers: headers,
          jsonBody: true,
          requestType: Request.post,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              // invoices = InvoiceTypesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting invoices $e");
    }
    return ResponseResult(status, "");
  }
}
