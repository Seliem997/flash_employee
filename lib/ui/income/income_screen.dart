import 'package:flash_employee/ui/income/widgets/income_item.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/attributeOptionModel.dart';
import '../../providers/income_provider.dart';
import '../../utils/colors.dart';
import '../../utils/enum/date_formats.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/attribute_selector.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
    super.initState();
  }

  void loadData({bool clearSearch = false}) async {
    final IncomeProvider incomeProvider =
        Provider.of<IncomeProvider>(context, listen: false);
    if (!clearSearch) {
      incomeProvider.resetIncomeScreen();
    }
    incomeProvider.getIncomes();
    incomeProvider.getIncomeCounters();
  }

  @override
  Widget build(BuildContext context) {
    final IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Income",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: Stack(
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
                    incomeProvider.searchIncomes(value!);
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
                              title: "Payment Type",
                              choices: AttributeOption.incomePaymentOptions,
                              previouslySelectedChoice:
                                  incomeProvider.selectedPaymentType,
                              onValueChanged: (value) {
                                incomeProvider.selectedPaymentType = value;
                              },
                            );
                          },
                        );
                      },
                      labelText: incomeProvider.selectedPaymentType?.title ??
                          'Payment type',
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
                            showDateRangePicker(
                                    context: context,

                                    firstDate:
                                        DateTime.utc(DateTime.now().year),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 180)))
                                .then((value) {
                              if (value != null) {
                                print('object');
                                incomeProvider.selectedDateFrom = value.start;
                                incomeProvider.selectedDateTo = value.end;
                              }
                            });
                          },
                          labelText: incomeProvider.selectedDateFrom != null
                              ? "${DateFormat(DFormat.dmDecorated.key).format(incomeProvider.selectedDateFrom!)} -> ${DateFormat(DFormat.dmDecorated.key).format(incomeProvider.selectedDateTo!)}"
                              : 'Today',
                          textColor: AppColor.filterGrey,
                          backgroundButton: const Color(0xFFF0F0F0),
                          borderColor: AppColor.filterGrey,
                          border: true,
                        ),
                        horizontalSpace(5),
                        Visibility(
                          visible: incomeProvider.selectedDateFrom != null,
                          child: CustomContainer(
                              onTap: () {
                                incomeProvider.selectedDateFrom = null;
                                incomeProvider.selectedDateTo = null;
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
                Expanded(
                  child: RefreshIndicator(
                      edgeOffset: 0,
                      displacement: 0,
                      onRefresh: () async {
                        loadData();
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          incomeProvider.loadingIncomes || incomeProvider.incomes ==null
                              ? const DataLoader()
                              : incomeProvider.incomes!.isEmpty
                                  ? const NoDataPlaceHolder(useExpand: false)
                                  : ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          symmetricEdgeInsets(vertical: 10),
                                      shrinkWrap: true,
                                      itemCount: incomeProvider.incomes!.length,
                                      itemBuilder: (context, index) {
                                        return IncomeItem(
                                            income:
                                                incomeProvider.incomes![index]);
                                      },
                                      separatorBuilder: (context, index) =>
                                          verticalSpace(15)),
                        ],
                      )),
                ),
                verticalSpace(200)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomContainer(
              width: double.infinity,
              height: 215,
              backgroundColorDark: const Color(0xff444444),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(32), topLeft: Radius.circular(32)),
              backgroundColor: const Color(0xffC7E4F8),
              padding: symmetricEdgeInsets(horizontal: 20, vertical: 15),
              borderColor: AppColor.primary,
              alignment: Alignment.center,
              child: incomeProvider.loadingIncomeCounters
                  ? DataLoader()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Cash : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalCash ?? "0"} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.grey,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Mada machine : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalMadaMachine ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.grey,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Mada gateway : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalMadaVisaPay ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.grey,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Wallet : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalWallet ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.pendingButton,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Total invoices : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                      color: AppColor.pendingButton,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalInvoices ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.pendingButton,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'STC Pay : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalStcPayNow ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.grey,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Apple Pay : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalApplePay ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.grey,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Bank transfer : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalBankTransfer ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: AppColor.grey,
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Total left : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                      color: Color(0xff008A0E),
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalLeft ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: Color(0xff008A0E),
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Total cash left : ',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.semiBold,
                                      color: Color(0xff011BA3),
                                    ),
                                    TextWidget(
                                      text:
                                          '${incomeProvider.incomeCountersData?.totalCashLeft ?? 0} SR',
                                      textSize: 14,
                                      fontWeight: MyFontWeight.medium,
                                      color: Color(0xff011BA3),
                                    ),
                                  ],
                                ),
                                verticalSpace(12),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: 'Total :  ',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                            TextWidget(
                              text:
                                  '${incomeProvider.incomeCountersData?.totalDay ?? 0} SR',
                              textSize: 14,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
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
