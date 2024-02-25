import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/services/invoices_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/attributeOptionModel.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../ui/request_details/widgets/pdf_viewer_screen.dart';
import '../ui/widgets/app_loader.dart';
import '../ui/widgets/navigate.dart';
import '../utils/apis.dart';
import '../utils/enum/date_formats.dart';
import '../utils/enum/languages.dart';

class InvoicesProvider extends ChangeNotifier {
  final InvoicesService invoicesService = InvoicesService();
  List<InvoiceData>? invoices;
  List<InvoiceTypeData>? invoicesTypes;
  InvoiceTypeData? _selectedInvoiceTypeData;
  DateTime? _newInvoiceDate = DateTime.now();
  TimeOfDay? _selectedTime;
  double invoiceAmount = 0;
  bool dateError = false;
  bool typeError = false;
  bool timeError = false;
  bool amountError = false;
  bool _hideTotals = false;
  AttributeOption? _selectedInvoiceCategory;
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    getInvoices();
  }

  AttributeOption? get selectedInvoiceCategory => _selectedInvoiceCategory;

  set selectedInvoiceCategory(AttributeOption? value) {
    _selectedInvoiceCategory = value;
    if (value != null) {
      getInvoices();
    }
    notifyListeners();
  }

  bool get hideTotals => _hideTotals;

  set hideTotals(bool value) {
    _hideTotals = value;
    notifyListeners();
  }

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

  DateTime? get newInvoiceDate => _newInvoiceDate;

  set newInvoiceDate(DateTime? value) {
    _newInvoiceDate = value;
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
    await invoicesService
        .getInvoices(
            category: _selectedInvoiceCategory == null ||
                    _selectedInvoiceCategory!.value == "all"
                ? ""
                : _selectedInvoiceCategory!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      // loadingInvoices = false;
      if (value.status == Status.success) {
        invoices = value.data as List<InvoiceData>?;
      }
    });
    await invoicesService.getInvoicesSum(date: _selectedDate != null
        ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
        : "").then((value) {
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

  Future searchInvoices(String invoiceId) async {
    loadingInvoices = true;
    totalInvoices = 0;
    notifyListeners();
    await invoicesService
        .getInvoices(
            invoiceId: invoiceId,
            category: _selectedInvoiceCategory == null ||
                    _selectedInvoiceCategory!.value == "all"
                ? ""
                : _selectedInvoiceCategory!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      if (value.status == Status.success) {
        invoices = value.data as List<InvoiceData>?;
      }
    });
    loadingInvoices = false;
    notifyListeners();
  }

  Future<Status> addInvoice() async {
    Status status = Status.error;
    await invoicesService
        .addInvoice(
            date: DateFormat(DFormat.ymd.key, LanguageKey.en.key)
                .format(_newInvoiceDate!),
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
    _newInvoiceDate = DateTime.now();
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
    if (newInvoiceDate == null) {
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

  void downloadInvoice(BuildContext context, int index) async {
    AppLoader.showLoader(context);
    await Dio()
        .download(Api.downloadInvoice(invoices![index].id!),
            '/storage/emulated/0/Download/invoice${invoices![index].id!}.pdf')
        .then((value) {
      AppLoader.stopLoader();
      if (value.statusCode == 200) {
        CustomSnackBars.successSnackBar(context, "Downloaded Successfully");
        navigateTo(
            context,
            PdfViewerPage(
                path:
                    '/storage/emulated/0/Download/invoice${invoices![index].id!}.pdf'));
      } else {
        CustomSnackBars.somethingWentWrongSnackBar(context);
      }
    });
  }

  void resetInvoicesScreen() {
    _selectedInvoiceCategory = null;
    _selectedDate = null;
  }
}
