import 'dart:developer';
import 'package:flash_employee/models/inventoryModel.dart';
import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/models/profileModel.dart';
import 'package:flash_employee/models/requestDetailsModel.dart';
import 'package:flash_employee/models/requestsModel.dart';

import '../base/service/base_service.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';

class RequestsService extends BaseService {
  Future<ResponseResult> getRequests() async {
    Status status = Status.error;
    List<RequestData>? requests;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getRequests,
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              requests = RequestsModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting requests $e");
    }
    return ResponseResult(status, requests);
  }

  Future<ResponseResult> getRequestDetails(String requestId) async {
    Status status = Status.error;
    RequestData? requestData;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getRequestDetails(requestId),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              requestData = RequestDetailsModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting requests $e");
    }
    return ResponseResult(status, requestData);
  }

  Future<ResponseResult> updateRequestStatus(
      String requestId, String nextStatus) async {
    Status status = Status.error;
    Map<String, dynamic> body = {"status": nextStatus};
    try {
      await requestFutureData(
          api: Api.updateRequestStatus(requestId),
          body: body,
          requestType: Request.patch,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting requests $e");
    }
    return ResponseResult(status, "");
  }

  Future<ResponseResult> lateRequest(String requestId, int minutes) async {
    Status status = Status.error;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    Map<String, dynamic> body = {"late_time": minutes};
    try {
      await requestFutureData(
          api: Api.lateRequest(requestId),
          body: body,
          requestType: Request.patch,
          headers: headers,
          jsonBody: true,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting requests $e");
    }
    return ResponseResult(status, "");
  }
}
