import 'dart:developer';
import 'package:flash_employee/models/incomeCountersModel.dart';
import 'package:flash_employee/models/incomesModel.dart';
import 'package:flash_employee/models/inventoryModel.dart';
import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/models/profileModel.dart';
import 'package:flash_employee/utils/enum/date_formats.dart';
import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';

class IncomeService extends BaseService {
  Future<ResponseResult> getIncomes(
      {String incomeId = "",
      String paymentType = "",
      String dateFrom = "",
      String dateTo = ""}) async {
    Status status = Status.error;
    List<IncomeData>? incomes;
    try {
      await requestFutureData(
          api: Api.getIncomes(
              incomeId: incomeId,
              dateFrom: dateFrom,
              dateTo: dateTo,
              paymentType: paymentType),
          // body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              incomes = IncomesModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting incomes $e");
    }
    return ResponseResult(status, incomes);
  }

  Future<ResponseResult> getIncomeCounters(
      {String dateFrom = "", String dateTo = ""}) async {
    Status status = Status.error;
    IncomeCountersData? incomeCounters;
    Map<String, dynamic> body = {
      "employee_id": CacheHelper.returnData(key: CacheKey.userId),
      "date_time": DateFormat(DFormat.ymd.key).format(DateTime.now())
    };
    try {
      await requestFutureData(
          api: Api.getIncomeCounters(dateFrom: dateFrom, dateTo: dateTo),
          body: body,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              incomeCounters = IncomeCountersModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting income counters $e");
    }
    return ResponseResult(status, incomeCounters);
  }
}
