import 'package:intl/intl.dart';

import 'enum/date_formats.dart';

class Api {
  static const String testUrl = "https://ahmos.smartsols.co/api";

  static const String imageUrl =
      "https://ahmos-dental.com/public/images/products/thumb/";
  static const String baseUrl = "https://dashboard.flashwashapp.com/api";

  static const String login = "$baseUrl/employee/login";
  static const String getMyProfile = "$baseUrl/employee/my-profile";
  static const String getProblemSignIn = "$baseUrl/employee/maintenanceAll";
  static const String loginSocial = "$baseUrl/login-by-social-media";
  static const String forgotPassword = "$baseUrl/employee/forget-password";
  // static const String  = "$baseUrl/employee/my-invoices/sum";

  static String getInvoicesSum({String date = ""}) {
    String path = "$baseUrl/employee/my-invoices/sum";
    if (date.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}date=$date";
    } else {
      path +=
          "${path.contains("?") ? "&" : "?"}date=${DateFormat(DFormat.ymd.key).format(DateTime.now())}";
    }
    return path;
  }
  static String getInvoices(
      {String invoiceId = "", String category = "", String date = ""}) {
    String path = "$baseUrl/employee/my-invoices";
    if (invoiceId.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}search=$invoiceId";
    }
    if (category.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}category=$category";
    }
    if (date.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}date=$date";
    } else {
      path +=
          "${path.contains("?") ? "&" : "?"}date=${DateFormat(DFormat.ymd.key).format(DateTime.now())}";
    }
    return path;
  }

  static String getEmployees( other) => "$baseUrl/employee/all-employees?other=$other";
  static const String getWarehouses = "$baseUrl/employee/all-warehouses";
  static String downloadInvoice(int invoiceId) =>
      "$baseUrl/download-invoice/$invoiceId";

  static String getTransactions(
      {String transactionId = "", String type = "", String date = ""}) {
    String path = "$baseUrl/employee/my-transactions";
    if (transactionId.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}search=$transactionId";
    }
    if (type.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}type=$type";
    }
    if (date.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}date=$date";
    } else {
      path +=
          "${path.contains("?") ? "&" : "?"}date=${DateFormat(DFormat.ymd.key).format(DateTime.now())}";
    }
    return path;
  }

  static const String getTransactionReasons =
      "$baseUrl/employee/all-transaction-reasons";
  static const String getInventoryItems = "$baseUrl/employee/my-materials";
  static const String getContacts = "$baseUrl/employee/contactus";

  static String getIncomeCounters({String dateFrom = "", String dateTo = ""}) {
    String path = "$baseUrl/employee/getIncomeDetails";
    if (dateFrom.isNotEmpty && dateTo.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}date=$dateFrom";
      path += "${path.contains("?") ? "&" : "?"}date2=$dateTo";
    } else {
      path +=
          "${path.contains("?") ? "&" : "?"}date=${DateFormat(DFormat.ymd.key).format(DateTime.now())}";
    }
    return path;
  }

  static const String getBasicServices = "$baseUrl/services?type=basic";

  static const String getExtraServices = "$baseUrl/services?type=extra";

  static const String getOtherServices = "$baseUrl/services?type=other";

  static const String getManufacturers = "$baseUrl/customer/manufacturers";

  static const String getManufacturersOfType =
      "$baseUrl/customer/vehicle_types/get/by/type/id/";

  static const String getVehiclesModels =
      "$baseUrl/customer/vehicle_models/get/by/manufacturers/id/";

  static String updateVehicle(int vehicleId) =>
      "$baseUrl/update-vehicle/$vehicleId";

  static String updateRequestServices(int reqId) =>
      "$baseUrl/employee/change-request-services/$reqId";

  static String getInventoryItemsOfWarehouse(int warehouseId) =>
      "$baseUrl/employee/materials/any-warehouse/$warehouseId";
  static const String getInvoiceTypes = "$baseUrl/employee/invoice-types";
  static const String addInvoice = "$baseUrl/employee/invoices";
  static const String addTransactions = "$baseUrl/employee/add-transactions";
  static const String checkCode = "$baseUrl/check-code";
  static const String resetPassword = "$baseUrl/reset-password";
  static const String register = "$baseUrl/register";
  static const String contactUs = "$baseUrl/contact-us";
  static const String updateProfile = "$baseUrl/employee/update-my-profile";
  static const String notifications = "$baseUrl/employee/my-notification";
  static const String seeNotification = "$baseUrl/employee/see_notifications";
  static String getIncomes(
      {String incomeId = "",
      String paymentType = "",
      String dateFrom = "",
      String dateTo = ""}) {
    String path = "$baseUrl/employee/incomes";
    if (incomeId.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}search=$incomeId";
    }
    if (paymentType.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}pay_by=$paymentType";
    }
    if (dateFrom.isNotEmpty && dateTo.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}date=$dateFrom";
      path += "${path.contains("?") ? "&" : "?"}date2=$dateTo";
    } else {
      path +=
          "${path.contains("?") ? "&" : "?"}date=${DateFormat(DFormat.ymd.key).format(DateTime.now())}";
    }
    return path;
  }

  static String getRequests(
      {String reqIdOrCustomerName = "",
      String statusType = "",
      String date = ""}) {
    String path = "$baseUrl/employee/requests";
    if (reqIdOrCustomerName.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}search=$reqIdOrCustomerName";
    }
    if (statusType.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}status=$statusType";
    }
    if (date.isNotEmpty) {
      path += "${path.contains("?") ? "&" : "?"}date=$date";
    } else {
      path +=
          "${path.contains("?") ? "&" : "?"}date=${DateFormat(DFormat.ymd.key).format(DateTime.now())}";
    }
    return path;
  }

  static String getRequestDetails(String requestId, double? lat, double? long,) =>
      "$baseUrl/employee/requests/$requestId?lat=$lat&lang=$long";

  static String updateRequestStatus(String requestId) =>
      "$baseUrl/employee/update-request-status/$requestId";

  static String lateRequest(String requestId) =>
      "$baseUrl/employee/update-request-late-time/$requestId";
}
