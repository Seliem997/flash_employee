import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/services/invoices_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/inventoryModel.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../services/inventory_service.dart';
import '../utils/enum/date_formats.dart';
import '../utils/enum/languages.dart';

class InventoryProvider extends ChangeNotifier {
  final InventoryService inventoryService = InventoryService();
  List<InventoryItemData>? inventoryItems;
  bool loadingInventoryItems = true;

  Future getInventoryItems() async {
    loadingInventoryItems = true;
    notifyListeners();
    await inventoryService.getInventoryItems().then((value) {
      loadingInventoryItems = false;
      if (value.status == Status.success) {
        inventoryItems = value.data as List<InventoryItemData>?;
      }
    });
    notifyListeners();
  }

  // Future<Status> addInvoice() async {
  //   Status status = Status.error;
  //   await invoicesService
  //       .addInvoice(
  //           date: DateFormat(DFormat.ymd.key, LanguageKey.en.key)
  //               .format(_selectedDate!),
  //           time: "${_selectedTime!.hour}:${_selectedTime!.minute}:00",
  //           invoiceTypeId: selectedInvoiceTypeData!.id.toString(),
  //           amount: invoiceAmount.toString())
  //       .then((value) {
  //     status = value.status;
  //   });
  //   return status;
  // }

  // bool checkValidation(BuildContext context) {
  //   bool isValid = true;
  //   if (selectedDate == null) {
  //     isValid = false;
  //     CustomSnackBars.failureSnackBar(context, "Date Required!");
  //   }
  //   if (selectedTime == null) {
  //     isValid = false;
  //     CustomSnackBars.failureSnackBar(context, "Time Required!");
  //   }
  //   if (selectedInvoiceTypeData == null) {
  //     isValid = false;
  //     CustomSnackBars.failureSnackBar(context, "Invoice Type Required!");
  //   }
  //   if (invoiceAmount == 0) {
  //     isValid = false;
  //     CustomSnackBars.failureSnackBar(context, "Invoice amount Required!");
  //   }
  //   return isValid;
  // }
}
