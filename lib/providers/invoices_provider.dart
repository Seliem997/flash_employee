import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/services/invoices_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../utils/enum/date_formats.dart';
import '../utils/enum/languages.dart';

class InvoicesProvider extends ChangeNotifier {
  final InvoicesService invoicesService = InvoicesService();
  List<InvoiceData>? invoices;
  List<InvoiceTypeData>? invoicesTypes;
  InvoiceTypeData? _selectedInvoiceTypeData;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  double invoiceAmount = 0;
  bool dateError = false;
  bool typeError = false;
  bool timeError = false;
  bool amountError = false;
  XFile? invoicePhoto;

  void uploadAttachment(ImageSource source) async {
    await ImagePicker.platform
        .getImage(source: source, imageQuality: 30)
        .then((value) {
      invoicePhoto = value;
    });
    notifyListeners();
  }

  void removeAttachment() async {
    invoicePhoto = null;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    if (value != null) {
      dateError = false;
    }
    notifyListeners();
  }

  InvoiceTypeData? get selectedInvoiceTypeData => _selectedInvoiceTypeData;

  set selectedInvoiceTypeData(InvoiceTypeData? value) {
    _selectedInvoiceTypeData = value;
    if (value != null) {
      typeError = false;
    }
    notifyListeners();
  }

  bool loadingInvoices = true;
  bool loadingInvoiceTypes = true;
  double totalInvoices = 0;

  Future getInvoices() async {
    loadingInvoices = true;
    totalInvoices = 0;
    notifyListeners();
    await invoicesService.getInvoices().then((value) {
      // loadingInvoices = false;
      if (value.status == Status.success) {
        invoices = value.data as List<InvoiceData>?;
      }
    });
    await invoicesService.getInvoicesSum().then((value) {
      loadingInvoices = false;
      if (value.status == Status.success) {
        invoicesTypes = value.data as List<InvoiceTypeData>?;
        invoicesTypes!.forEach((element) {
          totalInvoices += element.amountSum!;
        });
      }
    });
    notifyListeners();
  }

  Future<Status> addInvoice() async {
    Status status = Status.error;
    await invoicesService
        .addInvoice(
            date: DateFormat(DFormat.ymd.key, LanguageKey.en.key)
                .format(_selectedDate!),
            time: "${_selectedTime!.hour}:${_selectedTime!.minute}:00",
            invoiceTypeId: selectedInvoiceTypeData!.id.toString(),
            amount: invoiceAmount.toString())
        .then((value) {
      status = value.status;
    });
    return status;
  }

  Future getInvoicesTypes() async {
    dateError = false;
    typeError = false;
    timeError = false;
    amountError = false;
    loadingInvoiceTypes = true;
    _selectedInvoiceTypeData = null;
    _selectedDate = null;
    _selectedTime = null;
    invoicePhoto = null;
    invoiceAmount = 0;
    totalInvoices = 0;
    notifyListeners();
    await invoicesService.getInvoicesTypes().then((value) {
      loadingInvoiceTypes = false;
      if (value.status == Status.success) {
        invoicesTypes = value.data as List<InvoiceTypeData>?;
      }
    });
    notifyListeners();
  }

  TimeOfDay? get selectedTime => _selectedTime;

  set selectedTime(TimeOfDay? value) {
    _selectedTime = value;
    if (value != null) {
      timeError = false;
    }
    notifyListeners();
  }

  bool checkValidation(BuildContext context) {
    bool isValid = true;
    if (selectedDate == null) {
      isValid = false;
      dateError = true;
      // CustomSnackBars.failureSnackBar(context, "Date Required!");
    } else {
      dateError = false;
    }
    if (selectedTime == null) {
      isValid = false;
      timeError = true;
      // CustomSnackBars.failureSnackBar(context, "Time Required!");
    } else {
      timeError = false;
    }
    if (selectedInvoiceTypeData == null) {
      isValid = false;
      typeError = true;
      // CustomSnackBars.failureSnackBar(context, "Invoice Type Required!");
    } else {
      typeError = false;
    }
    if (invoiceAmount == 0) {
      isValid = false;
      amountError = true;
      // CustomSnackBars.failureSnackBar(context, "Invoice amount Required!");
    } else {
      amountError = false;
    }
    notifyListeners();
    return isValid;
  }
}
