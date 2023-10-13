enum DFormat {
  hm('hh:mm'),
  dmy('d-M-y'),
  dmyDecorated('dd / MM / y'),
  dmDecorated('dd / MM'),
  ymd('y-MM-dd');

  const DFormat(this.key);
  final String key;
}
