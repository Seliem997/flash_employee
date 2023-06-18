import 'package:change_case/change_case.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../models/attributeOptionModel.dart';
import '../../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class AttributeTypeSelector extends StatefulWidget {
  const AttributeTypeSelector({
    Key? key,
    required this.onValueChanged,
    required this.choices,
    required this.title,
    this.previouslySelectedChoice,
  }) : super(key: key);
  final ValueChanged<AttributeOption?> onValueChanged;
  final List<AttributeOption> choices;
  final String title;
  final AttributeOption? previouslySelectedChoice;

  @override
  State<AttributeTypeSelector> createState() => _AttributeTypeSelectorState();
}

class _AttributeTypeSelectorState extends State<AttributeTypeSelector> {
  AttributeOption? selectedChoice;
  List<AttributeOption> choices = [];

  @override
  void initState() {
    selectedChoice = widget.previouslySelectedChoice;
    choices.insert(0, const AttributeOption("All", "all"));
    choices.addAll(widget.choices);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: CustomContainer(
        // height: 300,
        width: 100.w - 200,
        backgroundColor: AppColor.white,
        backgroundColorDark: AppColor.secondaryDarkColor,
        padding: symmetricEdgeInsets(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomContainer(
              borderColorDark: Colors.transparent,
              height: 30,
              child: Stack(
                children: [
                  Center(
                    child: TextWidget(
                      text: widget.title.toCapitalCase(),
                      textSize: 16,
                      height: .9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Positioned(
                      right: 5,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close)))
                ],
              ),
            ),
            verticalSpace(2),
            Divider(thickness: 1.2),
            ListView.separated(
              shrinkWrap: true,
              itemCount: choices.length,
              itemBuilder: (context, index) {
                return CustomContainer(
                  padding: EdgeInsets.zero,
                  borderColorDark: Colors.transparent,
                  radiusCircular: 5,
                  alignment: Alignment.center,
                  height: 50,
                  onTap: () {
                    selectedChoice = choices[index];
                    setState(() {});
                  },
                  child: ListTile(
                    selected: selectedChoice == choices[index],
                    title: Text(choices[index].title.toCapitalCase()),
                    trailing: Radio<AttributeOption>(
                      value: choices[index],
                      groupValue: selectedChoice,
                      onChanged: (AttributeOption? value) {
                        selectedChoice = choices[index];
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => verticalSpace(10),
            ),
            verticalSpace(20),
            DefaultButton(
              text: "Apply",
              width: 150,
              onPressed: () {
                // if (selectedChoice != null && selectedChoice!.value != "all") {
                widget.onValueChanged(selectedChoice);
                // } else {
                //   widget.onValueChanged(null);
                // }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
