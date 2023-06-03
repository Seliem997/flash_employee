import 'package:flash_employee/models/dutyModel.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/enum/shift_type.dart';
import 'package:flash_employee/utils/enum/week_days.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/loginModel.dart';
import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class DutyScreen extends StatefulWidget {
  DutyScreen({Key? key, this.duties}) : super(key: key);
  final List<Duties>? duties;

  @override
  State<DutyScreen> createState() => _DutyScreenState();
}

class _DutyScreenState extends State<DutyScreen> {
  Map<String, DutyItem> activeDuties = {};

  @override
  void initState() {
    processDuties();
    super.initState();
  }

  void processDuties() {
    for (var duty in widget.duties!) {
      if (!activeDuties.containsKey(duty.day!)) {
        activeDuties.addEntries({duty.day!: DutyItem(duty.day!)}.entries);
      }
      if (duty.shift! == ShiftType.first.key) {
        activeDuties[duty.day!]!.firstShift =
            "${duty.startAt!} - ${duty.endAt!}";
      } else {
        activeDuties[duty.day!]!.secondShift =
            "${duty.startAt!} - ${duty.endAt!}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Duty",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: widget.duties!.isEmpty
          ? NoDataPlaceHolder(useExpand: false)
          : Stack(
              children: [
                Padding(
                  padding: symmetricEdgeInsets(horizontal: 25, vertical: 10),
                  child: Column(
                    children: activeDuties.entries
                        .map((element) => CustomContainer(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.only(bottom: 20),
                              backgroundColor: Color(0xffD9EDFA),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  CustomContainer(
                                    width: 55,
                                    height: 73,
                                    backgroundColorDark: Color(0xff444444),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    backgroundColor: AppColor.primary,
                                    alignment: Alignment.center,
                                    child: TextWidget(
                                      text: element.value.weekday,
                                      textSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  horizontalSpace(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomContainer(
                                        backgroundColor: Color(0xffD9EDFA),
                                        borderColorDark: Colors.transparent,
                                        child: Row(
                                          children: [
                                            const TextWidget(
                                              text: "First Shift :",
                                              textSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            horizontalSpace(10),
                                            TextWidget(
                                              text: element.value.firstShift,
                                              textSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      verticalSpace(10),
                                      CustomContainer(
                                        backgroundColor: Color(0xffD9EDFA),
                                        borderColorDark: Colors.transparent,
                                        child: Row(
                                          children: [
                                            const TextWidget(
                                              text: "Second Shift :",
                                              textSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            horizontalSpace(10),
                                            TextWidget(
                                              text: element.value.secondShift,
                                              textSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
