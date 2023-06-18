import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flash_employee/events/events/invoice_added_event.dart';
import 'package:flash_employee/events/global_event_bus.dart';
import 'package:flash_employee/main.dart';
import 'package:flash_employee/ui/invoices/widgets/new_invoice_screen.dart';
import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/app_loader.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flash_employee/utils/apis.dart';
import 'package:flash_employee/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/attributeOptionModel.dart';
import '../../providers/invoices_provider.dart';
import '../../utils/colors.dart';
import '../../utils/enum/date_formats.dart';
import '../../utils/font_styles.dart';
import '../request_details/widgets/pdf_viewer_screen.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/attribute_selector.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();

    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    mainEventBus.on<InvoiceAddedEvent>().listen((event) {
      loadData();
    });
    super.initState();
  }

  void loadData({bool clearSearch = false}) async {
    final InvoicesProvider invoicesProvider =
        Provider.of<InvoicesProvider>(context, listen: false);
    if (!clearSearch) {
      invoicesProvider.resetInvoicesScreen();
    }
    await invoicesProvider.getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    final InvoicesProvider invoicesProvider =
        Provider.of<InvoicesProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      key: globalKey,
      appBar: AppBar(
        title: const TextWidget(
          text: "Invoices",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: invoicesProvider.loadingInvoices
          ? DataLoader()
          : Stack(
              // alignment: Alignment.center,
              children: [
                Padding(
                  padding: symmetricEdgeInsets(vertical: 15, horizontal: 24),
                  child: Column(
                    children: [
                      DefaultFormField(
                        controller: searchController,
                        hintText: 'ID Search',
                        hintStyle: TextStyle(
                          fontWeight: MyFontWeight.medium,
                          fontSize: 14,
                          color: const Color(0xFF949494),
                        ),
                        filled: true,
                        fillColor: AppColor.babyBlue,
                        onSubmit: (value) {
                          invoicesProvider.searchInvoices(value!);
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: SvgPicture.asset('assets/svg/search.svg'),
                        ),
                        suffixIcon: Visibility(
                          visible: searchController.text.isNotEmpty,
                          child: GestureDetector(
                            onTap: () {
                              searchController.clear();
                              loadData(clearSearch: true);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(15),
                      Row(
                        children: [
                          DefaultButtonWithIcon(
                            padding: symmetricEdgeInsets(horizontal: 10),
                            icon: SvgPicture.asset('assets/svg/filter.svg'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AttributeTypeSelector(
                                    title: "Category",
                                    choices: AttributeOption.invoiceCategories,
                                    previouslySelectedChoice: invoicesProvider
                                        .selectedInvoiceCategory,
                                    onValueChanged: (value) {
                                      invoicesProvider.selectedInvoiceCategory =
                                          value;
                                    },
                                  );
                                },
                              );
                            },
                            labelText: invoicesProvider
                                    .selectedInvoiceCategory?.title ??
                                'Category',
                            textColor: AppColor.filterGrey,
                            backgroundButton: const Color(0xFFF0F0F0),
                            borderColor: AppColor.filterGrey,
                            border: true,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              DefaultButtonWithIcon(
                                padding: symmetricEdgeInsets(horizontal: 10),
                                icon: SvgPicture.asset('assets/svg/filter.svg'),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate:
                                              invoicesProvider.selectedDate ??
                                                  DateTime.now(),
                                          firstDate:
                                              DateTime.utc(DateTime.now().year),
                                          lastDate: DateTime.now()
                                              .add(Duration(days: 180)))
                                      .then((value) {
                                    if (value != null) {
                                      invoicesProvider.selectedDate = value;
                                    }
                                  });
                                },
                                labelText: invoicesProvider.selectedDate != null
                                    ? DateFormat(DFormat.dmyDecorated.key)
                                        .format(invoicesProvider.selectedDate!)
                                    : 'Today',
                                textColor: AppColor.filterGrey,
                                backgroundButton: const Color(0xFFF0F0F0),
                                borderColor: AppColor.filterGrey,
                                border: true,
                              ),
                              horizontalSpace(5),
                              Visibility(
                                visible: invoicesProvider.selectedDate != null,
                                child: CustomContainer(
                                    onTap: () {
                                      invoicesProvider.selectedDate = null;
                                    },
                                    radiusCircular: 5,
                                    height: 40,
                                    borderColor: Colors.red[200],
                                    padding: EdgeInsets.all(3),
                                    backgroundColor: AppColor.borderGray,
                                    child: Icon(Icons.close,
                                        color: Colors.red, size: 17)),
                              )
                            ],
                          ),
                        ],
                      ),
                      verticalSpace(15),
                      invoicesProvider.invoices!.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: NoDataPlaceHolder(useExpand: false),
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemCount: invoicesProvider.invoices!.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) =>
                                    verticalSpace(10),
                                itemBuilder: (context, index) {
                                  return CustomContainer(
                                    onTap: () {
                                      // navigateTo(context, RequestDetailsScreen());
                                    },
                                    width: 345,
                                    radiusCircular: 6,
                                    backgroundColor: AppColor.invoiceColor,
                                    padding: symmetricEdgeInsets(
                                        vertical: 13, horizontal: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  TextWidget(
                                                    text: 'Request ID : ',
                                                    textSize: 14,
                                                    fontWeight:
                                                        MyFontWeight.semiBold,
                                                  ),
                                                  TextWidget(
                                                    text: invoicesProvider
                                                        .invoices![index].id
                                                        .toString(),
                                                    textSize: 14,
                                                    fontWeight:
                                                        MyFontWeight.medium,
                                                    color: AppColor.grey,
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(12),
                                              Row(
                                                children: [
                                                  TextWidget(
                                                    text: 'Type : ',
                                                    textSize: 14,
                                                    fontWeight:
                                                        MyFontWeight.semiBold,
                                                  ),
                                                  TextWidget(
                                                    text: invoicesProvider
                                                        .invoices![index]
                                                        .invoiceType!
                                                        .name
                                                        .toString(),
                                                    textSize: 14,
                                                    fontWeight:
                                                        MyFontWeight.medium,
                                                    color: AppColor.grey,
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(12),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/svg/alarm.svg'),
                                                  horizontalSpace(15),
                                                  TextWidget(
                                                    text: invoicesProvider
                                                        .invoices![index].time
                                                        .toString(),
                                                    textSize: 14,
                                                    fontWeight:
                                                        MyFontWeight.medium,
                                                    color: AppColor.grey,
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(10),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    size: 12,
                                                    color: Color(0xff616161),
                                                  ),
                                                  horizontalSpace(15),
                                                  TextWidget(
                                                    text: invoicesProvider
                                                        .invoices![index].date
                                                        .toString(),
                                                    textSize: 14,
                                                    fontWeight:
                                                        MyFontWeight.medium,
                                                    color: AppColor.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                invoicesProvider
                                                    .downloadInvoice(
                                                        context, index);
                                              },
                                              child: Image.asset(
                                                'assets/images/Export Pdf.png',
                                                color: MyApp.themeMode(context)
                                                    ? Colors.white
                                                    : Colors.black,
                                                height: 42,
                                                width: 42,
                                              ),
                                            ),
                                            verticalSpace(10),
                                            TextWidget(
                                              text:
                                                  '-${invoicesProvider.invoices![index].amount.toString()} SR',
                                              fontWeight: MyFontWeight.bold,
                                              textSize: 18,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultButton(
                        text: "Add new invoice",
                        fontSize: 18,
                        height: 48,
                        fontWeight: FontWeight.bold,
                        width: 320,
                        onPressed: () {
                          navigateTo(context, NewInvoiceScreen());
                        },
                      ),
                      verticalSpace(20),
                      CustomContainer(
                        // width: double.infinity,
                        // height: 140,
                        backgroundColorDark: const Color(0xff444444),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(32),
                            topLeft: Radius.circular(32)),
                        backgroundColor: const Color(0xffC7E4F8),
                        padding:
                            symmetricEdgeInsets(horizontal: 15, vertical: 4),
                        borderColor: AppColor.primary,
                        // alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: !invoicesProvider.hideTotals,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        invoicesProvider.invoicesTypes!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                            mainAxisExtent: 30),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          TextWidget(
                                            text:
                                                '${invoicesProvider.invoicesTypes![index].name!}: ',
                                            textSize: 14,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                          TextWidget(
                                            text:
                                                '${invoicesProvider.invoicesTypes![index].amountSum!} SR',
                                            textSize: 14,
                                            fontWeight: MyFontWeight.medium,
                                            color: AppColor.grey,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                CustomContainer(
                                  height: 40,
                                  borderColorDark: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        text: 'Total invoices :  ',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                        color: AppColor.redColor,
                                      ),
                                      TextWidget(
                                        text:
                                            '${invoicesProvider.totalInvoices} SR',
                                        textSize: 14,
                                        fontWeight: MyFontWeight.semiBold,
                                        color: AppColor.redColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: Icon(!invoicesProvider.hideTotals
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up),
                                  onPressed: () {
                                    invoicesProvider.hideTotals =
                                        !invoicesProvider.hideTotals;
                                  },
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }
}
