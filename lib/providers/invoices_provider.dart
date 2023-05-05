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
    notifyListeners();
  }

  InvoiceTypeData? get selectedInvoiceTypeData => _selectedInvoiceTypeData;

  set selectedInvoiceTypeData(InvoiceTypeData? value) {
    _selectedInvoiceTypeData = value;
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
    loadingInvoiceTypes = true;
    _selectedInvoiceTypeData = null;
    _selectedDate = null;
    _selectedTime = null;
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
    notifyListeners();
  }

  bool checkValidation(BuildContext context) {
    bool isValid = true;
    if (selectedDate == null) {
      isValid = false;
      CustomSnackBars.failureSnackBar(context, "Date Required!");
    }
    if (selectedTime == null) {
      isValid = false;
      CustomSnackBars.failureSnackBar(context, "Time Required!");
    }
    if (selectedInvoiceTypeData == null) {
      isValid = false;
      CustomSnackBars.failureSnackBar(context, "Invoice Type Required!");
    }
    if (invoiceAmount == 0) {
      isValid = false;
      CustomSnackBars.failureSnackBar(context, "Invoice amount Required!");
    }
    return isValid;
  }
}
