import 'dart:developer';

import 'package:flash_employee/models/attributeOptionModel.dart';
import 'package:flash_employee/models/requestsModel.dart';
import 'package:flash_employee/services/requests_service.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/utils/enum/date_formats.dart';
import 'package:flash_employee/utils/enum/status_types.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';
import '../events/events/request_updated_event.dart';
import '../events/global_event_bus.dart';
import '../models/manufacturersModel.dart';
import '../models/servicesModel.dart';
import '../models/vehiclesModelsModel.dart';
import '../services/vehicle_service.dart';
import '../ui/request_details/widgets/pdf_viewer_screen.dart';
import '../ui/widgets/navigate.dart';

import 'package:pdf/widgets.dart' as pw;

import '../utils/colors.dart';
import '../utils/enum/serviceType.dart';

class RequestsProvider extends ChangeNotifier {
  final RequestsService requestsService = RequestsService();
  final VehicleService vehicleService = VehicleService();

  List<RequestData>? requests;
  RequestData? selectedRequest;
  String? selectedRequestId;
  ServiceType? _selectedServiceType;
  ServiceData? _selectedBasicService;
  bool loadingRequests = true;
  bool _editingMode = false;
  List<ExtraServicesItem> selectedExtraServices = [];
  bool loadingRequestDetails = true;
  bool loadingBasicServices = true;
  bool loadingExtraServices = true;
  bool loadingOtherServices = true;
  bool loadingManufacturer = true;
  bool loadingModels = true;
  AttributeOption? _selectedStatusType;
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    getRequests();
  }

  AttributeOption? get selectedStatusType => _selectedStatusType;

  set selectedStatusType(AttributeOption? value) {
    _selectedStatusType = value;
    if (value != null) {
      getRequests();
    }
    notifyListeners();
  }

  void initServiceEditing() async {
    loadingBasicServices = true;
    loadingExtraServices = true;
    loadingOtherServices = true;
    extraServicesList = [];
    selectedExtraServices = [];
    notifyListeners();
    if (selectedRequest!.basicServices!.isNotEmpty) {
      _selectedServiceType = ServiceType.wash;
      await getBasicServices(
              cityId: selectedRequest!.city!.id!,
              vehicleId: selectedRequest!.vehicleRequest!.id!)
          .then((value) {
        for (var element in basicServicesList) {
          if (element.id == selectedRequest!.services![0].id) {
            _selectedBasicService = element;
          }
        }
      });
      await getExtraServices(
              cityId: selectedRequest!.city!.id!,
              vehicleId: selectedRequest!.vehicleRequest!.id!)
          .then((value) {
        for (var element in selectedRequest!.extraServices!) {
          for (var service in extraServicesList) {
            if (element.id == service.id) {
              // selectedExtraServices.add(ExtraServicesItem(
              //     service.id!, service.countable! ? element.count! : 1));
              if (service.countable!) {
                service.quantity = element.count!;
              } else {
                service.isSelected = true;
              }
            }
          }
        }
      });
    } else {
      _selectedServiceType = ServiceType.otherService;
      await getOtherServices(
              cityId: selectedRequest!.city!.id!,
              vehicleId: selectedRequest!.vehicleRequest!.id!)
          .then((value) {
        for (var element in basicServicesList) {
          if (element.id == selectedRequest!.services![0].id) {
            _selectedBasicService = element;
          }
        }
      });
    }
  }

  void initVehicleEditing() async {
    loadingManufacturer = true;
    manufacturerDataList = [];
    notifyListeners();
    if (selectedRequest!.vehicleRequest != null) {
      _selectedServiceType = ServiceType.wash;
      await getManufacturers(selectedRequest!.vehicleRequest!.vehicleTypeId!)
          .then((value) {
        for (var element in manufacturerDataList) {
          if (element.id == selectedRequest!.vehicleRequest!.manufacturerId) {
            selectedManufacture = element;
          }
        }
      });
      vehiclesModelsDataList = [];
      await getVehiclesModels(manufactureId: selectedManufacture!.id!)
          .then((value) {
        for (var element in vehiclesModelsDataList) {
          if (element.id == selectedRequest!.vehicleRequest!.vehicleModelId!) {
            selectedVehicleModel = element;
          }
        }
      });
    }
  }

  Future getRequests() async {
    loadingRequests = true;
    notifyListeners();
    await requestsService
        .getRequests(
            statusType: _selectedStatusType == null ||
                    _selectedStatusType!.value == "all"
                ? ""
                : _selectedStatusType!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      loadingRequests = false;
      if (value.status == Status.success) {
        requests = value.data as List<RequestData>?;
        // requests!.addAll(value.data as List<RequestData>);
      }
    });
    notifyListeners();
  }

  Future searchRequests(String requestIdOrCustomerName) async {
    loadingRequests = true;
    requests = [];
    notifyListeners();
    await requestsService
        .getRequests(
            requestIdOrCustomerName: requestIdOrCustomerName,
            statusType: _selectedStatusType == null ||
                    _selectedStatusType!.value == "all"
                ? ""
                : _selectedStatusType!.value,
            date: _selectedDate != null
                ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
                : "")
        .then((value) {
      if (value.status == Status.success) {
        log("Search Result :${value.data}");
        requests = value.data as List<RequestData>?;
        log("Search Result :${requests!.length}");
      }
    });
    loadingRequests = false;
    notifyListeners();
  }

  Future getRequestDetails({String? reqId}) async {
    loadingRequestDetails = true;
    _editingMode = false;
    notifyListeners();
    await requestsService
        .getRequestDetails(reqId ?? selectedRequestId!)
        .then((value) {
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
        mainEventBus.fire(RequestUpdatedEvent());

        getRequestDetails();
      } else {
        CustomSnackBars.somethingWentWrongSnackBar(context);
      }
    });
  }

  List<ServiceData> basicServicesList = [];
  Future getBasicServices({
    required int cityId,
    required int vehicleId,
  }) async {
    loadingBasicServices = true;
    notifyListeners();
    await requestsService
        .getBasicServices(cityId: cityId, vehicleId: vehicleId)
        .then((value) {
      loadingBasicServices = false;
      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    notifyListeners();
  }

  List<ServiceData> extraServicesList = [];
  Future getExtraServices({required int cityId, required int vehicleId}) async {
    loadingExtraServices = true;
    notifyListeners();
    await requestsService
        .getExtraServices(
      cityId: cityId,
      vehicleId: vehicleId,
    )
        .then((value) {
      loadingExtraServices = false;

      if (value.status == Status.success) {
        extraServicesList = value.data;
      }
    });
    notifyListeners();
  }

  List<ServiceData> otherServicesList = [];
  Future getOtherServices({required int cityId, required int vehicleId}) async {
    loadingBasicServices = true;
    notifyListeners();
    await requestsService
        .getOtherServices(
      cityId: cityId,
      vehicleId: vehicleId,
    )
        .then((value) {
      loadingBasicServices = false;

      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    notifyListeners();
  }

  void resetRequestsScreen() {
    _selectedStatusType = null;
    _selectedDate = null;
  }

  Future<void> updateRequestServices(BuildContext context) async {
    AppLoader.showLoader(context);
    extraServicesList.forEach((element) {
      if (element.quantity > 0 || element.isSelected) {
        selectedExtraServices
            .add(ExtraServicesItem(element.id!, element.quantity));
      }
    });
    await requestsService
        .updateRequestServices(
            requestId: selectedRequest!.id!,
            basicServiceId: _selectedBasicService!.id!,
            selectedExtraServices: selectedExtraServices)
        .then((value) {
      AppLoader.stopLoader();
      if (value.status == Status.success) {
      } else {}
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
      nextStatus = StatusType.onTheWay2.key;
    } else if (selectedRequest!.status == StatusType.onTheWay.key) {
      nextStatus = StatusType.arrived2.key;
    } else if (selectedRequest!.status == StatusType.arrived.key) {
      nextStatus = StatusType.completed2.key;
    } else if (selectedRequest!.status == StatusType.initial.key) {
      nextStatus = StatusType.pending2.key;
    }
    return nextStatus;
  }

  Future savePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text('Request: ${selectedRequest?.requestId ?? "01"}',
                        textScaleFactor: 2),
                  ])),
          pw.Header(
              level: 2,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Request info', textScaleFactor: 2),
                    pw.Container(
                      width: 120,
                      height: 32,
                      decoration: pw.BoxDecoration(
                          color: selectedRequest!.status ==
                                  StatusType.completed.key
                              ? PdfColor.fromInt(AppColor.completedButton.value)
                              : selectedRequest!.status ==
                                      StatusType.pending.key
                                  ? PdfColor.fromInt(
                                      AppColor.pendingButton.value)
                                  : PdfColor.fromInt(
                                      AppColor.onTheWayButton.value),
                          borderRadius: pw.BorderRadius.circular(3)),
                      alignment: pw.Alignment.center,
                      child: pw.Text("${selectedRequest!.status}",
                          style: pw.TextStyle(
                              fontSize: 15, color: PdfColors.white)),
                    ),
                  ])),
          pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex("E0E0E0"),
                  border: pw.Border.all(color: PdfColors.grey),
                  borderRadius: pw.BorderRadius.circular(5)),
              padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Request ID: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(selectedRequest?.requestId.toString() ?? "01",
                          style: pw.TextStyle(
                            fontSize: 14,
                          )),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Date: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(selectedRequest?.date ?? "1/5/2023",
                          style: pw.TextStyle(fontSize: 14)),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Time: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(selectedRequest?.time ?? "12:00 AM",
                          style: pw.TextStyle(fontSize: 14)),
                    ]),
              ])),
          pw.SizedBox(height: 20),
          pw.Text('Customer Contact', textScaleFactor: 2),
          pw.SizedBox(height: 10),
          pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex("E0E0E0"),
                  border: pw.Border.all(color: PdfColors.grey),
                  borderRadius: pw.BorderRadius.circular(5)),
              padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Customer ID: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(selectedRequest?.customer?.id.toString() ?? "1",
                          style: pw.TextStyle(
                            fontSize: 14,
                          )),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Phone Number: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(selectedRequest?.customer?.phone ?? "",
                          style: pw.TextStyle(fontSize: 14)),
                    ]),
              ])),
          pw.SizedBox(height: 20),
          pw.Text('Vehicle Info', textScaleFactor: 2),
          pw.SizedBox(height: 10),
          pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex("F1F6FE"),
                  border: pw.Border.all(
                      color: PdfColor.fromInt(AppColor.primary.value)),
                  borderRadius: pw.BorderRadius.circular(5)),
              padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Type: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(
                          selectedRequest?.vehicleRequest?.vehicleTypeName
                                  .toString() ??
                              "",
                          style: pw.TextStyle(
                            fontSize: 14,
                          )),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Size: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(
                          selectedRequest?.vehicleRequest?.subVehicleTypeName
                                  .toString() ??
                              "",
                          style: pw.TextStyle(
                            fontSize: 14,
                          )),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Manufacture: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(
                          selectedRequest?.vehicleRequest?.manufacturerName
                                  .toString() ??
                              "",
                          style: pw.TextStyle(
                            fontSize: 14,
                          )),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Model: ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      pw.Text(
                          selectedRequest?.vehicleRequest?.vehicleModelName
                                  .toString() ??
                              "",
                          style: pw.TextStyle(
                            fontSize: 14,
                          )),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Row(children: [
                        pw.Text('Color: ',
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        pw.Text(selectedRequest?.vehicleRequest?.color ?? "",
                            style: pw.TextStyle(
                              fontSize: 14,
                            )),
                        // pw.Container(
                        //   height: 25,
                        //   width: 40,
                        //   decoration: pw.BoxDecoration(
                        //       color: PdfColor.fromInt(int.tryParse(
                        //           selectedRequest?.vehicleRequest?.color ??
                        //               "808080")!),
                        //       borderRadius: pw.BorderRadius.circular(3)),
                        // ),
                      ]),
                      pw.SizedBox(width: 40),
                      pw.Row(children: [
                        pw.Text('Plate: ',
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        pw.Text(selectedRequest?.vehicleRequest?.numbers ?? "",
                            style: pw.TextStyle(
                              fontSize: 14,
                            )),
                      ]),
                    ]),
              ])),
          pw.SizedBox(height: 20),
          pw.Text('Services', textScaleFactor: 2),
          pw.SizedBox(height: 10),
          pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex("F1F6FE"),
                  border: pw.Border.all(
                      color: PdfColor.fromInt(AppColor.primary.value)),
                  borderRadius: pw.BorderRadius.circular(5)),
              padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Service Type: ',
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          pw.Text(
                              selectedRequest!.services![0].type == "basic"
                                  ? "Wash"
                                  : "Other Service",
                              style: pw.TextStyle(
                                fontSize: 14,
                              )),
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Basic: ',
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          pw.Text("${selectedRequest!.services![0].title}",
                              style: pw.TextStyle(
                                fontSize: 14,
                              )),
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Manufacture: ',
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          pw.Text(
                              selectedRequest?.vehicleRequest?.manufacturerName
                                      .toString() ??
                                  "",
                              style: pw.TextStyle(
                                fontSize: 14,
                              )),
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Extra: ',
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          pw.SizedBox(height: 2),
                          pw.ListView.separated(
                            padding: pw.EdgeInsets.zero,
                            // shrinkWrap: true,
                            // physics:
                            // const NeverScrollableScrollPhysics(),
                            itemCount: selectedRequest!.extraServices!.length,
                            itemBuilder: (context, index) {
                              return pw.Text(
                                "${selectedRequest!.extraServices![index].title}",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                pw.SizedBox(height: 5),
                          )
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Row(children: [
                            pw.Text('Service Duration : ',
                                style: pw.TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            pw.Text("${selectedRequest!.totalDuration} Min",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                )),
                          ]),
                        ]),
                  ])),
        ];
      },
    ));
    final String dir = (await getApplicationDocumentsDirectory()).path;

    final file = File('$dir/req${selectedRequest?.requestId}.pdf');
    await file.writeAsBytes(await pdf.save());
    // navigateTo(
    //     context, PdfViewerPage(path: '$dir/req${selectedRequest?.requestId}.pdf'));
    Share.shareXFiles([XFile('$dir/req${selectedRequest?.requestId}.pdf')],
        text: "");
  }

  ServiceData? get selectedBasicService => _selectedBasicService;

  set selectedBasicService(ServiceData? value) {
    _selectedBasicService = value;
    notifyListeners();
  }

  bool get editingMode => _editingMode;

  set editingMode(bool value) {
    _editingMode = value;
    notifyListeners();
  }

  ServiceType? get selectedServiceType => _selectedServiceType;

  set selectedServiceType(ServiceType? value) {
    _selectedServiceType = value;
    _selectedBasicService = null;
    basicServicesList = [];
    extraServicesList = [];
    if (value == ServiceType.wash) {
      getBasicServices(
          cityId: selectedRequest!.city!.id!,
          vehicleId: selectedRequest!.vehicleRequest!.id!);
      getExtraServices(
          cityId: selectedRequest!.city!.id!,
          vehicleId: selectedRequest!.vehicleRequest!.id!);
    } else {
      getOtherServices(
          cityId: selectedRequest!.city!.id!,
          vehicleId: selectedRequest!.vehicleRequest!.id!);
    }
    notifyListeners();
  }

  ManufacturerData? selectedManufacture;

  List<ManufacturerData> manufacturerDataList = [];

  Future getManufacturers(int vehicleTypeId) async {
    loadingManufacturer = true;
    notifyListeners();
    await vehicleService
        .getManufacturersOfType(vehicleTypeId: vehicleTypeId)
        .then((value) {
      loadingManufacturer = false;
      if (value.status == Status.success) {
        manufacturerDataList = value.data;
      }
    });
    notifyListeners();
  }

  void setSelectedManufacture(ManufacturerData manufacture) {
    selectedVehicleModel = null;
    selectedManufacture = manufacture;
    notifyListeners();
  }

  VehiclesModelsData? selectedVehicleModel;

  List<VehiclesModelsData> vehiclesModelsDataList = [];
  Future getVehiclesModels({context, required int manufactureId}) async {
    loadingModels = true;
    notifyListeners();
    await vehicleService
        .getVehiclesModels(manufactureId: manufactureId)
        .then((value) {
      loadingModels = false;
      if (value.status == Status.success) {
        vehiclesModelsDataList = value.data;
      }
    });
    notifyListeners();
  }

  void setSelectedVehicle(VehiclesModelsData vehicle) {
    selectedVehicleModel = vehicle;
    notifyListeners();
  }

  void resetDropDownValues() {
    manufacturerDataList = [];
    vehiclesModelsDataList = [];
    loadingManufacturer = true;
    loadingModels = false;
    selectedVehicleModel = null;
    selectedManufacture = null;
    notifyListeners();
  }
}
