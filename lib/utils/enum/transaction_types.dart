enum TransactionType {
  recharge('recharge'),
  refunds('refunds'),
  request('request');

  const TransactionType(this.key);
  final String key;
}
