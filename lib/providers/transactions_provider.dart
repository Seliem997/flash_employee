import 'package:flash_employee/events/events/tranaction_added_event.dart';
import 'package:flash_employee/models/employeesModel.dart';
import 'package:flash_employee/models/transactionReasonsModel.dart';
import 'package:flash_employee/models/transactionsModel.dart';
import 'package:flash_employee/models/warehousesModel.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../events/global_event_bus.dart';
import '../models/attributeOptionModel.dart';
import '../models/inventoryModel.dart';
import '../services/inventory_service.dart';
import '../services/transactions_service.dart';
import '../utils/enum/date_formats.dart';

class TransactionsProvider extends ChangeNotifier {
  final TransactionsService transactionsService = TransactionsService();
  List<TransactionData>? transactions = [];
  List<EmployeeData>? employees = [EmployeeData(username: "Me")];
  List<WarehouseData>? warehouses = [WarehouseData(name: "Me")];
  List<ReasonData>? reasons;
  List<InventoryItemData>? inventoryItems = [];
  List<InventoryItemData>? selectedItems = [];
  ReasonData? _selectedReason;
  EmployeeData? _selectedEmployee;
  WarehouseData? _selectedWarehouse;
  bool loadingReasons = true;
  bool loadingWarehouses = true;
  bool loadingEmployees = true;
  bool loadingInventoryItems = false;
  bool loadingTransactions = false;

  AttributeOption? _selectedTransactionType;
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    loadTransactions();
  }

  AttributeOption? get selectedTransactionType => _selectedTransactionType;

  set selectedTransactionType(AttributeOption? value) {
    _selectedTransactionType = value;
    if (value != null) {
      loadTransactions();
    }
    notifyListeners();
  }

  Future loadNewTransactionData() async {
    loadingReasons = true;
    loadingWarehouses = true;
    loadingEmployees = true;
    loadingInventoryItems = false;
    _selectedEmployee = null;
    _selectedReason = null;
    _selectedWarehouse = null;
    inventoryItems = [];
    selectedItems = [];
    warehouses = [WarehouseData(name: "Me")];
    employees = [EmployeeData(username: "Me")];
    notifyListeners();
    await transactionsService.getTransactionReasons().then((value) {
      loadingReasons = false;
      if (value.status == Status.success) {
        reasons = value.data as List<ReasonData>?;
        notifyListeners();
      }
    });
    await transactionsService.getWarehouses().then((value) {
      loadingWarehouses = false;
      loadingEmployees = false;
      if (value.status == Status.success) {
        warehouses!.addAll(value.data as List<WarehouseData>);
        notifyListeners();
      }
    });
  }

  Future getInventoryItemsOfWarehouse(int warehouseId) async {
    loadingInventoryItems = true;
    inventoryItems = [];
    selectedItems = [];
    notifyListeners();
    await transactionsService
        .getInventoryItemsOfWarehouse(warehouseId)
        .then((value) {
      loadingInventoryItems = false;
      if (value.status == Status.success) {
        inventoryItems = value.data as List<InventoryItemData>?;
      }
    });
    notifyListeners();
  }

  Future getMineInventoryItems() async {
    final InventoryService inventoryService = InventoryService();

    loadingInventoryItems = true;
    inventoryItems = [];
    selectedItems = [];
    notifyListeners();
    await inventoryService.getInventoryItems().then((value) {
      loadingInventoryItems = false;
      if (value.status == Status.success) {
        inventoryItems = value.data as List<InventoryItemData>?;
      }
    });
    notifyListeners();
  }

  Future loadTransactions() async {
    loadingTransactions = true;
    transactions = [];
    notifyListeners();
    await transactionsService
        .getTransactions(
            type: _selectedTransactionType == null ||
                    _selectedTransactionType!.value == "all"
                ? ""
                : _selectedTransactionType!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      loadingTransactions = false;
      if (value.status == Status.success) {
        transactions = value.data as List<TransactionData>?;
      }
    });
    notifyListeners();
  }

  Future searchTransactions(String transactionId) async {
    loadingTransactions = true;
    transactions = [];
    notifyListeners();
    await transactionsService
        .getTransactions(
            transactionId: transactionId,
            type: _selectedTransactionType == null ||
                    _selectedTransactionType!.value == "all"
                ? ""
                : _selectedTransactionType!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      loadingTransactions = false;
      if (value.status == Status.success) {
        transactions = value.data as List<TransactionData>?;
      }
    });
    notifyListeners();
  }

  bool checkValidation(BuildContext context) {
    bool isValid = true;
    selectedItems =
        inventoryItems!.where((element) => element.neededQuantity > 0).toList();
    final itemsWithoutReason =
        selectedItems!.where((element) => element.reason == null).toList();
    if (selectedWarehouse!.name! == "Me" &&
        (selectedEmployee == null || selectedEmployee!.username! == "Me")) {
      isValid = false;
      CustomSnackBars.failureSnackBar(
          context, "You can't transact from \"Me\" to \"Me\"");
    } else if (selectedItems!.isEmpty) {
      isValid = false;
      CustomSnackBars.failureSnackBar(
          context, "You should select materials to transact");
    } else if (itemsWithoutReason.isNotEmpty) {
      isValid = false;
      CustomSnackBars.failureSnackBar(
          context, "Every material should has a transaction reason");
    }
    return isValid;
  }

  Future addTransaction(BuildContext context) async {
    AppLoader.showLoader(context);
    await transactionsService
        .addTransaction(
            warehouse: selectedWarehouse!,
            employee: selectedEmployee,
            items: selectedItems!)
        .then((value) {
      AppLoader.stopLoader();
      if (value.status == Status.success) {
        CustomSnackBars.successSnackBar(context, "Transaction Done!");
        Navigator.pop(context);
        Navigator.pop(context);
        mainEventBus.fire(TransactionAddedEvent());
      } else {
        CustomSnackBars.somethingWentWrongSnackBar(context);
      }
    });
    // return result;
  }

  ReasonData? get selectedReason => _selectedReason;

  set selectedReason(ReasonData? value) {
    _selectedReason = value;
    notifyListeners();
  }

  EmployeeData? get selectedEmployee => _selectedEmployee;

  set selectedEmployee(EmployeeData? value) {
    _selectedEmployee = value;
    notifyListeners();
  }

  WarehouseData? get selectedWarehouse => _selectedWarehouse;

  set selectedWarehouse(WarehouseData? value) {
    _selectedWarehouse = value;
    if (value != null && value.name != "Me") {
      selectedEmployee = null;
      employees = [EmployeeData(username: "Me")];
      getInventoryItemsOfWarehouse(value.id!);
    } else {
      employees = [EmployeeData(username: "Me")];
      selectedEmployee = null;
      loadingEmployees = true;
      notifyListeners();
      transactionsService.getEmployees(other: 1).then((value) {
        loadingEmployees = false;
        if (value.status == Status.success) {
          employees!.addAll(value.data as List<EmployeeData>);
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }

  void resetTransactionsScreen() {
    _selectedTransactionType = null;
    _selectedDate = null;
  }
}
