enum PaymentType {
  stc('stc_pay'),
  stcTitle('STC Pay'),
  wallet('wallet'),
  creditCard('credit_card'),
  creditCardTitle('Credit Card'),
  applePay('apple_pay'),
  applePayTitle('Apple Pay'),
  bankTransfer('bank_transfer'),
  bankTransferTitle('Bank Transfer'),
  package('package'),
  cash('cash');

  const PaymentType(this.key);
  final String key;
}
