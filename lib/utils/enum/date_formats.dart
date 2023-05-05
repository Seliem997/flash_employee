enum DFormat {
  hm('hh:mm'),
  dmy('d-M-y'),
  ymd('y-M-d');

  const DFormat(this.key);
  final String key;
}
