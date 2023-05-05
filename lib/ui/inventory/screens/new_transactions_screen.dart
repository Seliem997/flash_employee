import 'package:flash_employee/models/employeesModel.dart';
import 'package:flash_employee/models/transactionReasonsModel.dart';
import 'package:flash_employee/models/warehousesModel.dart';
import 'package:flash_employee/providers/inventory_provider.dart';
import 'package:flash_employee/providers/transactions_provider.dart';
import 'package:flash_employee/ui/widgets/custom_button.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/spaces.dart';
import 'package:change_case/change_case.dart';

import 'widgets/confirm_transaction_dialog.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({Key? key}) : super(key: key);

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final TransactionsProvider transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    await transactionsProvider.loadNewTransactionData();
  }

  @override
  Widget build(BuildContext context) {
    final TransactionsProvider transactionsProvider =
        Provider.of<TransactionsProvider>(context);
    final InventoryProvider inventoryProvider =
        Provider.of<InventoryProvider>(context);

    return Scaffold(
        // backgroundColor: Colors.white,
        key: globalKey,
        appBar: AppBar(
          title: const TextWidget(
            text: "Add New Transaction",
            textSize: 18,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          leading: BackButton(),
          centerTitle: true,
        ),
        body: transactionsProvider.loadingWarehouses ||
                transactionsProvider.loadingEmployees
            ? DataLoader()
            : CustomContainer(
                padding: symmetricEdgeInsets(horizontal: 25, vertical: 30),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "From",
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold),
                            verticalSpace(10),
                            CustomContainer(
                              width: 135,
                              radiusCircular: 5,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              backgroundColor: Color(0xffE1ECFF),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: transactionsProvider.selectedWarehouse,
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  hint: TextWidget(
                                    text: "Select",
                                    color: Colors.black,
                                    textSize: 16,
                                  ),
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(),
                                  items: List.generate(
                                      transactionsProvider.warehouses!.length,
                                      (index) =>
                                          DropdownMenuItem<WarehouseData>(
                                              value: transactionsProvider
                                                  .warehouses![index],
                                              child: Text(
                                                  transactionsProvider
                                                      .warehouses![index].name!
                                                      .toCapitalCase(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)))),
                                  onChanged: (newValue) {
                                    if (newValue!.name == "Me") {
                                      transactionsProvider.inventoryItems =
                                          inventoryProvider.inventoryItems!;
                                    }
                                    transactionsProvider.selectedWarehouse =
                                        newValue;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomContainer(
                            height: 35,
                            width: 45,
                            margin: symmetricEdgeInsets(vertical: 5),
                            child:
                                Image.asset("assets/images/arrow-right 1.png")),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "To",
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold),
                            verticalSpace(10),
                            CustomContainer(
                              width: 135,
                              radiusCircular: 5,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              backgroundColor: Color(0xffE1ECFF),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: transactionsProvider.selectedEmployee,
                                  iconSize: 24,
                                  elevation: 16,
                                  hint: TextWidget(
                                    text: "Me",
                                    color: Colors.black,
                                    textSize: 16,
                                  ),
                                  isExpanded: true,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(),
                                  items: List.generate(
                                      transactionsProvider.employees!.length,
                                      (index) => DropdownMenuItem<EmployeeData>(
                                          value: transactionsProvider
                                              .employees![index],
                                          child: Text(
                                              transactionsProvider
                                                  .employees![index].username!
                                                  .toCapitalCase(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)))),
                                  onChanged: (newValue) {
                                    // error = false;
                                    transactionsProvider.selectedEmployee =
                                        newValue;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(55),
                    transactionsProvider.loadingInventoryItems
                        ? DataLoader()
                        : transactionsProvider.inventoryItems!.isEmpty
                            ? Container()
                            : Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                          text: "Name",
                                          textSize: 16,
                                          fontWeight: MyFontWeight.semiBold),
                                      const Spacer(),
                                      TextWidget(
                                          text: "Reason",
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
                                CustomContainer(
                                  height: 490,
                                  child: ListView.builder(
                                    itemCount: transactionsProvider
                                        .inventoryItems!.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return CustomContainer(
                                        onTap: () {
                                          // navigateTo(context, RequestDetailsScreen());
                                        },
                                        width: 345,
                                        radiusCircular: 6,
                                        backgroundColor:
                                            AppColor.inventoryColor,
                                        padding: symmetricEdgeInsets(
                                            vertical: 13, horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                              text: transactionsProvider
                                                  .inventoryItems![index].name!,
                                              textSize: 14,
                                              fontWeight: MyFontWeight.semiBold,
                                            ),
                                            CustomContainer(
                                              width: 110,
                                              radiusCircular: 5,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 35,
                                              backgroundColor:
                                                  Color(0xff9F9F9F),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  value: transactionsProvider
                                                      .inventoryItems![index]
                                                      .reason,
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  isExpanded: true,
                                                  hint: TextWidget(
                                                    text: "Choose",
                                                    color: Colors.black,
                                                    textSize: 12,
                                                  ),
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(),
                                                  items: List.generate(
                                                      transactionsProvider
                                                          .reasons!.length,
                                                      (index) => DropdownMenuItem<
                                                              ReasonData>(
                                                          value: transactionsProvider
                                                              .reasons![index],
                                                          child: Text(
                                                              transactionsProvider
                                                                  .reasons![
                                                                      index]
                                                                  .name!
                                                                  .toCapitalCase(),
                                                              style: const TextStyle(
                                                                  color:
                                                                      Colors.black,
                                                                  fontSize: 12)))),
                                                  onChanged: (newValue) {
                                                    // error = false;
                                                    transactionsProvider
                                                        .inventoryItems![index]
                                                        .reason = newValue;
                                                    transactionsProvider
                                                        .notifyListeners();
                                                  },
                                                ),
                                              ),
                                            ),
                                            CustomContainer(
                                                width: 72,
                                                height: 23,
                                                child: Row(
                                                  children: [
                                                    CustomContainer(
                                                      onTap: () {
                                                        if (transactionsProvider
                                                                .inventoryItems![
                                                                    index]
                                                                .neededQuantity >
                                                            0) {
                                                          transactionsProvider
                                                              .inventoryItems![
                                                                  index]
                                                              .neededQuantity--;
                                                          transactionsProvider
                                                              .notifyListeners();
                                                        }
                                                      },
                                                      width: 20,
                                                      height: 20,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/minus.png'),
                                                          fit:
                                                              BoxFit.fitHeight),
                                                    ),
                                                    horizontalSpace(9),
                                                    TextWidget(
                                                      text:
                                                          '${transactionsProvider.inventoryItems![index].neededQuantity}',
                                                      textSize: 14,
                                                      fontWeight:
                                                          MyFontWeight.semiBold,
                                                    ),
                                                    horizontalSpace(9),
                                                    CustomContainer(
                                                      onTap: () {
                                                        transactionsProvider
                                                            .inventoryItems![
                                                                index]
                                                            .neededQuantity++;
                                                        transactionsProvider
                                                            .notifyListeners();
                                                      },
                                                      width: 20,
                                                      height: 20,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/plus.png'),
                                                          fit:
                                                              BoxFit.fitHeight),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                DefaultButton(
                                  text: "Submit",
                                  fontSize: 16,
                                  height: 48,
                                  width: double.infinity,
                                  onPressed: () async {
                                    if (transactionsProvider
                                        .checkValidation(context)) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ConfirmTransactionDialog();
                                        },
                                      );
                                      // AppLoader.showLoader(context);
                                      // await invoicesProvider.addInvoice().then((value) {
                                      //   AppLoader.stopLoader();
                                      //   if (value == Status.success) {
                                      //     CustomSnackBars.successSnackBar(
                                      //         context, "Invoice Added!");
                                      //     mainEventBus.fire(InvoiceAddedEvent());
                                      //     Navigator.pop(context, true);
                                      //   } else {
                                      //     CustomSnackBars.somethingWentWrongSnackBar(context);
                                      //   }
                                      // });
                                    }
                                  },
                                )
                              ]),
                  ],
                ),
              ));
  }
}
