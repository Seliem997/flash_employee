import 'package:flash_employee/utils/enum/invoice_categories.dart';
import 'package:flash_employee/utils/enum/transaction_types.dart';

import '../utils/enum/payment_types.dart';
import '../utils/enum/status_types.dart';
import '../utils/enum/transaction_type.dart';

class AttributeOption {
  final String value;
  final String title;

  static final List<AttributeOption> statusOptions = [
    AttributeOption(StatusType.arrived.key, StatusType.arrived2.key),
    AttributeOption(StatusType.pending.key, StatusType.pending2.key),
    AttributeOption(StatusType.onTheWay.key, StatusType.onTheWay2.key),
    AttributeOption(StatusType.canceled.key, StatusType.canceled2.key),
    AttributeOption(StatusType.completed.key, StatusType.completed2.key),
  ];

  static List<AttributeOption> invoiceCategories = [
    AttributeOption(InvoiceCategory.employee.key, InvoiceCategory.employee.key),
    AttributeOption(InvoiceCategory.office.key, InvoiceCategory.office.key),
  ];

  static List<AttributeOption> transactionTypes = [
    AttributeOption(TransactionType.request.key, TransactionType.request.key),
    AttributeOption(TransactionType.recharge.key, TransactionType.recharge.key),
    AttributeOption(TransactionType.refunds.key, TransactionType.refunds.key),
  ];

  static final List<AttributeOption> incomePaymentOptions = [
    AttributeOption(PaymentType.cash.key, PaymentType.cash.key),
    AttributeOption(PaymentType.stcTitle.key, PaymentType.stc.key),
    AttributeOption(
        PaymentType.bankTransferTitle.key, PaymentType.bankTransfer.key),
    AttributeOption(PaymentType.applePayTitle.key, PaymentType.applePay.key),
    AttributeOption(
        PaymentType.creditCardTitle.key, PaymentType.creditCard.key),
    AttributeOption(PaymentType.package.key, PaymentType.package.key),
    AttributeOption(PaymentType.wallet.key, PaymentType.wallet.key),
  ];

  const AttributeOption(this.title, this.value);
}
