import 'package:flash_employee/models/incomesModel.dart';
import 'package:flash_employee/services/income_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeProvider extends ChangeNotifier {
  final IncomeService incomeService = IncomeService();
  List<IncomeData>? incomes;
  bool loadingIncomes = true;

  Future getIncomes() async {
    loadingIncomes = true;
    notifyListeners();
    await incomeService.getIncomes().then((value) {
      loadingIncomes = false;
      if (value.status == Status.success) {
        incomes = value.data as List<IncomeData>?;
      }
    });
    notifyListeners();
  }
}
