enum FromToTransactionType {
  fromWarehouseToEmployee('from_warehouse_to_employee'),
  fromEmployeeToEmployee('from_employee_to_employee');

  const FromToTransactionType(this.key);
  final String key;
}
