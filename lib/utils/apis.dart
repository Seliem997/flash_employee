class Api {
  static const String testUrl = "https://ahmos.smartsols.co/api";

  static const String imageUrl =
      "https://ahmos-dental.com/public/images/products/thumb/";
  static const String baseUrl = "https://dashboard.flashwashapp.com/api";

  static const String login = "$baseUrl/employee/login";
  static const String getMyProfile = "$baseUrl/employee/my-profile";
  static const String loginSocial = "$baseUrl/login-by-social-media";
  static const String forgotPassword = "$baseUrl/employee/forget-password";
  static const String getInvoices = "$baseUrl/employee/my-invoices";
  static const String getEmployees = "$baseUrl/employee/all-employees";
  static const String getWarehouses = "$baseUrl/employee/all-warehouses";
  static const String getTransactions = "$baseUrl/employee/my-transactions";
  static const String getTransactionReasons =
      "$baseUrl/employee/all-transaction-reasons";
  static const String getInventoryItems = "$baseUrl/employee/my-materials";
  static const String getIncomes = "$baseUrl/employee/incomes";
  static String getInventoryItemsOfWarehouse(int warehouseId) =>
      "$baseUrl/employee/materials/any-warehouse/$warehouseId";
  static const String getInvoicesSum = "$baseUrl/employee/my-invoices/sum";
  static const String getInvoiceTypes = "$baseUrl/employee/invoice-types";
  static const String addInvoice = "$baseUrl/employee/invoices";
  static const String addTransactions = "$baseUrl/employee/add-transactions";
  static const String checkCode = "$baseUrl/check-code";
  static const String resetPassword = "$baseUrl/reset-password";
  static const String register = "$baseUrl/register";
  static const String contactUs = "$baseUrl/contact-us";
  static const String updateProfile = "$baseUrl/update-profile";
  static const String getRequests = "$baseUrl/employee/requests";
  static String getRequestDetails(String requestId) =>
      "$baseUrl/employee/requests/$requestId";
  static String updateRequestStatus(String requestId) =>
      "$baseUrl/employee/update-request-status/$requestId";

  static String lateRequest(String requestId) =>
      "$baseUrl/employee/update-request-late-time/$requestId";
}
