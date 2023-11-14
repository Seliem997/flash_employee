import 'dart:developer';
import 'package:flash_employee/models/employeesModel.dart';
import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/models/profileModel.dart';
import 'package:flash_employee/models/transactionReasonsModel.dart';
import 'package:flash_employee/models/transactionsModel.dart';
import 'package:flash_employee/models/warehousesModel.dart';

import '../base/service/base_service.dart';
import '../models/inventoryModel.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';
import '../utils/enum/transaction_type.dart';

class TransactionsService extends BaseService {
  Future<ResponseResult> getTransactions(
      {String transactionId = "", String type = "", String date = ""}) async {
    Status status = Status.error;
    List<TransactionData>? transactions;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getTransactions(
            transactionId: transactionId,
            date: date,
            type: type,
          ),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              transactions = TransactionsModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting transactions $e");
    }
    return ResponseResult(status, transactions);
  }

  Future<ResponseResult> getWarehouses() async {
    Status status = Status.error;
    List<WarehouseData>? warehouses;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getWarehouses,
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              warehouses = WarehousesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting warehouses $e");
    }
    return ResponseResult(status, warehouses);
  }

  Future<ResponseResult> getEmployees({int? other}) async {
    Status status = Status.error;
    List<EmployeeData>? employees;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getEmployees(other),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              employees = EmployeesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting employees $e");
    }
    return ResponseResult(status, employees);
  }

  Future<ResponseResult> getTransactionReasons() async {
    Status status = Status.error;
    List<ReasonData>? reasons;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getTransactionReasons,
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              reasons = TransactionReasonsModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting transactions reasons $e");
    }
    return ResponseResult(status, reasons);
  }

  Future<ResponseResult> getInventoryItemsOfWarehouse(int warehouseId) async {
    Status status = Status.error;
    List<InventoryItemData>? inventoryItems;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getInventoryItemsOfWarehouse(warehouseId),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              inventoryItems = InventoryModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting inventory items $e");
    }
    return ResponseResult(status, inventoryItems);
  }

  Future<ResponseResult> addTransaction({
    required WarehouseData warehouse,
    EmployeeData? employee,
    required List<InventoryItemData> items,
  }) async {
    Status status = Status.error;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    Map<String, dynamic> body = {
      "type": warehouse.name != "Me"
          ? FromToTransactionType.fromWarehouseToEmployee.key
          : FromToTransactionType.fromEmployeeToEmployee.key,
      if (warehouse.name != "Me") "warehouse_id": warehouse.id!,
      if (warehouse.name == "Me") "employee_id_to": employee!.id!,
      "items": items.map((e) => e.toJson()).toList()
    };

    try {
      await requestFutureData(
          api: Api.addTransactions,
          body: body,
          headers: headers,
          jsonBody: true,
          requestType: Request.post,
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
      logger.e("Error in adding transaction $e");
    }
    return ResponseResult(status, "");
  }
}
