import 'dart:developer';
import 'package:flash_employee/models/incomesModel.dart';
import 'package:flash_employee/models/inventoryModel.dart';
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

class IncomeService extends BaseService {
  Future<ResponseResult> getIncomes() async {
    Status status = Status.error;
    List<IncomeData>? incomes;
    // Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.getIncomes,
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
}
