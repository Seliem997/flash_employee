import 'package:flash_employee/utils/enum/week_days.dart';

class DutyItem {
  String weekday;
  String firstShift;
  String secondShift;
  DutyItem(this.weekday, {this.firstShift = "", this.secondShift = ""});
}
