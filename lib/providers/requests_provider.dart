import 'package:flash_employee/models/invoiceTypesModel.dart';
import 'package:flash_employee/models/requestsModel.dart';
import 'package:flash_employee/services/invoices_service.dart';
import 'package:flash_employee/services/requests_service.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/utils/enum/status_types.dart';
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
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class RequestsProvider extends ChangeNotifier {
  final RequestsService requestsService = RequestsService();
  List<RequestData>? requests;
  RequestData? selectedRequest;
  String? selectedRequestId;
  bool loadingRequests = true;
  bool loadingRequestDetails = true;

  Future getRequests() async {
    loadingRequests = true;
    notifyListeners();
    await requestsService.getRequests().then((value) {
      loadingRequests = false;
      if (value.status == Status.success) {
        requests = value.data as List<RequestData>?;
        // requests!.addAll(value.data as List<RequestData>);
      }
    });
    notifyListeners();
  }

  Future savePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  Future getRequestDetails() async {
    loadingRequestDetails = true;
    notifyListeners();
    await requestsService.getRequestDetails(selectedRequestId!).then((value) {
      loadingRequestDetails = false;
      if (value.status == Status.success) {
        selectedRequest = value.data as RequestData?;
      }
    });
    notifyListeners();
  }

  Future updateRequestStatus(BuildContext context,
      {bool cancel = false}) async {
    AppLoader.showLoader(context);
    await requestsService
        .updateRequestStatus(selectedRequestId!, nextStatus(cancel))
        .then((value) {
      AppLoader.stopLoader();
      if (value.status == Status.success) {
        CustomSnackBars.successSnackBar(context, "Status Updated");
        getRequestDetails();
      } else {
        CustomSnackBars.somethingWentWrongSnackBar(context);
      }
    });
  }

  Future lateRequest(BuildContext context, int minutes) async {
    if (minutes == 0) {
      CustomSnackBars.failureSnackBar(context, "Late minutes cannot be 0");
    } else {
      AppLoader.showLoader(context);

      await requestsService
          .lateRequest(selectedRequestId!, minutes)
          .then((value) {
        AppLoader.stopLoader();
        if (value.status == Status.success) {
          CustomSnackBars.successSnackBar(context, "Successful");
          Navigator.pop(context);
          getRequestDetails();
        } else {
          CustomSnackBars.somethingWentWrongSnackBar(context);
        }
      });
    }
  }

  String nextStatus(bool cancel) {
    String nextStatus = "";
    if (cancel) {
      nextStatus = StatusType.canceled.key;
    } else if (selectedRequest!.status == StatusType.pending.key) {
      nextStatus = StatusType.onTheWay.key;
    } else if (selectedRequest!.status == StatusType.onTheWay2.key) {
      nextStatus = StatusType.arrived2.key;
    } else if (selectedRequest!.status == StatusType.arrived.key) {
      nextStatus = StatusType.completed2.key;
    }
    return nextStatus;
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
