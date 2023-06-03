import '../utils/enum/status_types.dart';

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

  static List<AttributeOption> paymentOptions = [
    AttributeOption(StatusType.arrived.key, StatusType.arrived.key),
    AttributeOption(StatusType.pending.key, StatusType.pending2.key),
    AttributeOption(StatusType.onTheWay.key, StatusType.onTheWay2.key),
    AttributeOption(StatusType.canceled.key, StatusType.canceled2.key),
    AttributeOption(StatusType.completed.key, StatusType.completed2.key),
  ];

  static final List<AttributeOption> incomePaymentOptions = [
    AttributeOption(PaymentType.cash.key, PaymentType.cash.key),
    AttributeOption(PaymentType.stc.key, PaymentType.stc.key),
  ];

  const AttributeOption(this.title, this.value);
}
