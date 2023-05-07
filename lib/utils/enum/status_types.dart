enum StatusType {
  pending("Pending"),
  onTheWay('on_the_way'),
  onTheWay2('On the way'),
  arrived('Arrived'),
  arrived2('arrived'),
  completed('Complete'),
  completed2('completed'),
  canceled('canceled');

  const StatusType(this.key);
  final String key;
}
