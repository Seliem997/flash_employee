import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      key: globalKey,
      appBar: AppBar(
        title: const TextWidget(
          text: "My Inventory",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: symmetricEdgeInsets(vertical: 15, horizontal: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      TextWidget(
                          text: "Name",
                          textSize: 16,
                          fontWeight: MyFontWeight.semiBold),
                      const Spacer(),
                      TextWidget(
                          text: "Quantity",
                          textSize: 16,
                          fontWeight: MyFontWeight.semiBold),
                    ],
                  ),
                ),
                verticalSpace(15),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      CustomContainer(
                        onTap: () {
                          // navigateTo(context, RequestDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.inventoryColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Shampoo',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: '1 L',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(15),
                      CustomContainer(
                        onTap: () {
                          // navigateTo(context, RequestDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.inventoryColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Sponge',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: '4',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(15),
                      CustomContainer(
                        onTap: () {
                          // navigateTo(context, RequestDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.inventoryColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Nano Sponge',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: '5',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(15),
                      CustomContainer(
                        onTap: () {
                          // navigateTo(context, RequestDetailsScreen());
                        },
                        width: 345,
                        radiusCircular: 6,
                        backgroundColor: AppColor.inventoryColor,
                        padding:
                            symmetricEdgeInsets(vertical: 13, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Small Sponge',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text: '2',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(15),
                    ],
                  ),
                ),
                verticalSpace(15),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomContainer(
              width: double.infinity,
              height: 125,
              backgroundColor: Colors.transparent,
              padding: symmetricEdgeInsets(horizontal: 20, vertical: 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  DefaultButton(
                    text: "Add new transaction",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    width: 320,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                  ),
                  verticalSpace(15),
                  const TextWidget(
                    text: "Transaction history",
                    textSize: 14,
                    color: Color(0xff0067AF),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }
}
