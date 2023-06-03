import 'package:flash_employee/models/incomeCountersModel.dart';
import 'package:flash_employee/models/incomesModel.dart';
import 'package:flash_employee/services/income_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/attributeOptionModel.dart';
import '../utils/enum/date_formats.dart';

class IncomeProvider extends ChangeNotifier {
  final IncomeService incomeService = IncomeService();
  List<IncomeData>? incomes;
  IncomeCountersData? incomeCountersData;
  bool loadingIncomes = true;
  bool loadingIncomeCounters = true;

  AttributeOption? _selectedPaymentType;
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    getIncomes();
    getIncomeCounters();
  }

  AttributeOption? get selectedPaymentType => _selectedPaymentType;

  set selectedPaymentType(AttributeOption? value) {
    _selectedPaymentType = value;
    if (value != null) {
      getIncomes();
    }
    notifyListeners();
  }

  Future getIncomes() async {
    loadingIncomes = true;
    notifyListeners();
    await incomeService
        .getIncomes(
            paymentType: _selectedPaymentType == null ||
                    _selectedPaymentType!.value == "all"
                ? ""
                : _selectedPaymentType!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      loadingIncomes = false;
      if (value.status == Status.success) {
        incomes = value.data as List<IncomeData>?;
      }
    });
    notifyListeners();
  }

  Future getIncomeCounters() async {
    loadingIncomeCounters = true;
    notifyListeners();
    await incomeService.getIncomeCounters().then((value) {
      loadingIncomeCounters = false;
      if (value.status == Status.success) {
        incomeCountersData = value.data as IncomeCountersData?;
      }
    });
    notifyListeners();
  }

  Future searchIncomes(String requestIdOrCustomerName) async {
    loadingIncomes = true;
    incomes = [];
    notifyListeners();
    await incomeService
        .getIncomes(requestIdOrCustomerName: requestIdOrCustomerName)
        .then((value) {
      if (value.status == Status.success) {
        incomes = value.data as List<IncomeData>?;
      }
    });
    loadingIncomes = false;
    notifyListeners();
  }
}
