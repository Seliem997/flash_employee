enum StatusType {
  pending("Pending"),
  onTheWay('on_the_way'),
  onTheWay2('On the way'),
  arrived('Arrived'),
  completed('Complete'),
  completed2('completed'),
  canceled('canceled');

  const StatusType(this.key);
  final String key;
}
