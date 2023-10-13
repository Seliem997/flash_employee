class IncomeCountersModel {
  int? statusCode;
  Null? message;
  IncomeCountersData? data;

  IncomeCountersModel({this.statusCode, this.message, this.data});

  IncomeCountersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null
        ? new IncomeCountersData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class IncomeCountersData {
  String? totalCash;
  num? totalMadaMachine;
  num? totalMadaVisaPay;
  num? totalStcPayLater;
  num? totalStcPayNow;
  num? totalApplePay;
  num? totalWallet;
  num? totalBankTransfer;
  num? totalLeft;
  num? totalInvoices;
  num? totalCashLeft;
  num? totalDay;

  IncomeCountersData(
      {this.totalCash,
      this.totalMadaMachine,
      this.totalMadaVisaPay,
      this.totalStcPayLater,
      this.totalStcPayNow,
      this.totalApplePay,
      this.totalWallet,
      this.totalBankTransfer,
      this.totalLeft,
      this.totalInvoices,
      this.totalCashLeft,
      this.totalDay});

  IncomeCountersData.fromJson(Map<String, dynamic> json) {
    totalCash = json['totalCash'];
    totalMadaMachine = json['Total_mada_machine'];
    totalMadaVisaPay = json['Total_mada_visa_pay'];
    totalStcPayLater = json['Total_stc_pay_later'];
    totalStcPayNow = json['Total_stc_pay_now'];
    totalApplePay = json['Total_apple_pay'];
    totalWallet = json['Total_wallet'];
    totalBankTransfer = json['Total_bank_transfer'];
    totalLeft = json['totalLeft'];
    totalInvoices = json['totalInvoices'];
    totalCashLeft = json['totalCashLeft'];
    totalDay = json['totalDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCash'] = this.totalCash;
    data['Total_mada_machine'] = this.totalMadaMachine;
    data['Total_mada_visa_pay'] = this.totalMadaVisaPay;
    data['Total_stc_pay_later'] = this.totalStcPayLater;
    data['Total_stc_pay_now'] = this.totalStcPayNow;
    data['Total_apple_pay'] = this.totalApplePay;
    data['Total_wallet'] = this.totalWallet;
    data['Total_bank_transfer'] = this.totalBankTransfer;
    data['totalLeft'] = this.totalLeft;
    data['totalInvoices'] = this.totalInvoices;
    data['totalCashLeft'] = this.totalCashLeft;
    data['totalDay'] = this.totalDay;
    return data;
  }
}
