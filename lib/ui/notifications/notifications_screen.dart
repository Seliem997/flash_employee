import 'package:flash_employee/ui/widgets/custom_container.dart';
import 'package:flash_employee/ui/widgets/spaces.dart';
import 'package:flash_employee/utils/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Notifications",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: CustomContainer(
        borderColorDark: Colors.transparent,
        padding: symmetricEdgeInsets(horizontal: 25),
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return CustomContainer(
                padding: symmetricEdgeInsets(horizontal: 15, vertical: 10),
                radiusCircular: 5,
                height: 105,
                backgroundColor: AppColor.borderGray,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomContainer(
                          width: 220,
                          borderColorDark: Colors.transparent,
                          child: TextWidget(
                            text:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                            textSize: 13,
                            height: 1.2,
                            maxLines: 3,
                          ),
                        ),
                        CustomContainer(
                          width: 78,
                          height: 65,
                          radiusCircular: 5,
                          borderColorDark: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage("assets/images/Nature.png"),
                              fit: BoxFit.cover),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Color(0xff616161),
                        ),
                        horizontalSpace(15),
                        TextWidget(
                          text: "Monday , 23 January 2023 - 03:15 PM",
                          textSize: 10,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => verticalSpace(20)),
      ),
    );
  }
}
