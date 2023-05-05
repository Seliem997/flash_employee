enum TransactionType {
  fromWarehouseToEmployee('from_warehouse_to_employee'),
  fromEmployeeToEmployee('from_employee_to_employee');

  const TransactionType(this.key);
  final String key;
}
