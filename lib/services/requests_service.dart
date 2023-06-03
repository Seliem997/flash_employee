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
import '../models/servicesModel.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';

class RequestsService extends BaseService {
  Future<ResponseResult> getRequests(
      {String requestIdOrCustomerName = "",
      String statusType = "",
      String date = ""}) async {
    Status status = Status.error;
    List<RequestData>? requests;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getRequests(
            reqIdOrCustomerName: requestIdOrCustomerName,
            statusType: statusType,
            date: date,
          ),
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

  Future<ResponseResult> getBasicServices({
    required int cityId,
    required int vehicleId,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> basicServicesDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getBasicServices}&vehicle_id=$vehicleId&city_id=$cityId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              basicServicesDataList = ServicesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, basicServicesDataList);
  }

  Future<ResponseResult> getExtraServices(
      {required int cityId, required int vehicleId}) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> extraServicesDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getExtraServices}&vehicle_id=$vehicleId&city_id=$cityId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              extraServicesDataList = ServicesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, extraServicesDataList);
  }

  Future<ResponseResult> getOtherServices(
      {required int cityId, required int vehicleId}) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> extraServicesDataList = [];
    try {
      //&vehicle_id=$vehicleId
      await requestFutureData(
          api: '${Api.getOtherServices}&city_id=$cityId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              extraServicesDataList = ServicesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, extraServicesDataList);
  }

  Future<ResponseResult> updateRequestServices(
      {required int requestId,
      required int basicServiceId,
      required List<ExtraServicesItem> selectedExtraServices}) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "basic_service_id": basicServiceId,
      "extra_services_ids":
          selectedExtraServices.map((element) => element.toJson()).toList(),
    };

    try {
      await requestFutureData(
          api: Api.updateRequestServices(requestId),
          requestType: Request.post,
          body: body,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
            } catch (e) {
              logger.e("Error updating Services \n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in updating Services$e");
    }
    return ResponseResult(result, "");
  }
}
