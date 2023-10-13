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
  DateTime? _selectedDateFrom;
  DateTime? _selectedDateTo;

  DateTime? get selectedDateTo => _selectedDateTo;

  set selectedDateTo(DateTime? value) {
    _selectedDateTo = value;
    getIncomes();
    getIncomeCounters();
  }

  DateTime? get selectedDateFrom => _selectedDateFrom;

  set selectedDateFrom(DateTime? value) {
    _selectedDateFrom = value;
    notifyListeners();
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
            dateFrom: _selectedDateFrom != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDateFrom!)
                : "",
            dateTo: _selectedDateTo != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDateTo!)
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
    await incomeService
        .getIncomeCounters(
            dateFrom: _selectedDateFrom != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDateFrom!)
                : "",
            dateTo: _selectedDateTo != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDateTo!)
                : "")
        .then((value) {
      loadingIncomeCounters = false;
      if (value.status == Status.success) {
        incomeCountersData = value.data as IncomeCountersData?;
      }
    });
    notifyListeners();
  }

  Future searchIncomes(String incomeId) async {
    loadingIncomes = true;
    incomes = [];
    notifyListeners();
    await incomeService
        .getIncomes(
            incomeId: incomeId,
            paymentType: _selectedPaymentType == null ||
                    _selectedPaymentType!.value == "all"
                ? ""
                : _selectedPaymentType!.value,
            dateFrom: _selectedDateFrom != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDateFrom!)
                : "",
            dateTo: _selectedDateTo != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDateTo!)
                : "")
        .then((value) {
      if (value.status == Status.success) {
        incomes = value.data as List<IncomeData>?;
      }
    });
    loadingIncomes = false;
    notifyListeners();
  }

  void resetIncomeScreen() {
    _selectedPaymentType = null;
    _selectedDateFrom = null;
  }
}
