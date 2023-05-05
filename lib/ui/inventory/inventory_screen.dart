import 'package:flash_employee/events/events/tranaction_added_event.dart';
import 'package:flash_employee/providers/inventory_provider.dart';
import 'package:flash_employee/ui/inventory/screens/new_transactions_screen.dart';
import 'package:flash_employee/ui/inventory/screens/transactions_history_screen.dart';
import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../events/global_event_bus.dart';
import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    mainEventBus.on<TransactionAddedEvent>().listen((event) {
      navigateTo(context, TransactionsHistoryScreen());
    });
    super.initState();
  }

  void loadData() async {
    final InventoryProvider inventoryProvider =
        Provider.of<InventoryProvider>(context, listen: false);
    await inventoryProvider.getInventoryItems();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    final InventoryProvider inventoryProvider =
        Provider.of<InventoryProvider>(context);
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
        leading: BackButton(),
        centerTitle: true,
      ),
      body: inventoryProvider.loadingInventoryItems
          ? DataLoader()
          : inventoryProvider.inventoryItems!.isEmpty
              ? NoDataPlaceHolder()
              : Stack(
                  children: [
                    Padding(
                        padding:
                            symmetricEdgeInsets(vertical: 15, horizontal: 24),
                        child: Column(children: [
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
                              child: ListView.builder(
                            itemCount: inventoryProvider.inventoryItems!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return CustomContainer(
                                onTap: () {
                                  // navigateTo(context, RequestDetailsScreen());
                                },
                                width: 345,
                                radiusCircular: 6,
                                backgroundColor: AppColor.inventoryColor,
                                padding: symmetricEdgeInsets(
                                    vertical: 13, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: inventoryProvider
                                          .inventoryItems![index].name!,
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${inventoryProvider.inventoryItems![index].quantity!} ${inventoryProvider.inventoryItems![index].countType!.name}',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ))
                        ])),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomContainer(
                        width: double.infinity,
                        height: 125,
                        backgroundColor: Colors.transparent,
                        padding:
                            symmetricEdgeInsets(horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            DefaultButton(
                              text: "Add new transaction",
                              fontSize: 18,
                              height: 48,
                              fontWeight: FontWeight.bold,
                              width: 320,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                navigateTo(context, NewTransactionScreen());
                              },
                            ),
                            verticalSpace(15),
                            GestureDetector(
                              onTap: () {
                                navigateTo(
                                    context, TransactionsHistoryScreen());
                              },
                              child: const TextWidget(
                                text: "Transaction history",
                                textSize: 14,
                                color: Color(0xff0067AF),
                                fontWeight: FontWeight.bold,
                              ),
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
