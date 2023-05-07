import 'package:flash_employee/ui/income/widgets/income_item.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/income_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
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
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
    super.initState();
  }

  void loadData() async {
    final IncomeProvider incomeProvider =
        Provider.of<IncomeProvider>(context, listen: false);
    await incomeProvider.getIncomes();
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
                  hintText: 'ID Search',
                  hintStyle: TextStyle(
                    fontWeight: MyFontWeight.medium,
                    fontSize: 14,
                    color: const Color(0xFF949494),
                  ),
                  filled: true,
                  fillColor: AppColor.babyBlue,
                  icon: SvgPicture.asset('assets/svg/search.svg'),
                ),
                verticalSpace(15),
                Row(
                  children: [
                    DefaultButtonWithIcon(
                      padding: symmetricEdgeInsets(horizontal: 10),
                      icon: SvgPicture.asset('assets/svg/filter.svg'),
                      onPressed: () {},
                      labelText: 'Payment type',
                      textColor: AppColor.filterGrey,
                      backgroundButton: const Color(0xFFF0F0F0),
                      borderColor: AppColor.filterGrey,
                      border: true,
                    ),
                    const Spacer(),
                    DefaultButtonWithIcon(
                      padding: symmetricEdgeInsets(horizontal: 10),
                      icon: SvgPicture.asset('assets/svg/filter.svg'),
                      onPressed: () {},
                      labelText: 'Date filter',
                      textColor: AppColor.filterGrey,
                      backgroundButton: const Color(0xFFF0F0F0),
                      borderColor: AppColor.filterGrey,
                      border: true,
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
                          incomeProvider.loadingIncomes
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
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32), topLeft: Radius.circular(32)),
              backgroundColor: Color(0xffC7E4F8),
              padding: symmetricEdgeInsets(horizontal: 20, vertical: 15),
              borderColor: AppColor.primary,
              alignment: Alignment.center,
              child: Column(
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
                                text: '25 SR',
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
                                text: '200 SR',
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
                                text: '200 SR',
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
                                text: '0 SR',
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
                                text: '0 SR',
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
                                text: '25 SR',
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
                                text: '195 SR',
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
                                text: '64 SR',
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
                                text: '25 SR',
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
                                text: '25 SR',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomContainer(
                        height: 22,
                        width: 22,
                        padding: EdgeInsets.zero,
                        radiusCircular: 0,
                        backgroundColor: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage("assets/images/share.png"),
                            fit: BoxFit.fitHeight),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Total :  ',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              TextWidget(
                                text: '287.50 SR',
                                textSize: 14,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/Export Pdf.png',
                        height: 42,
                        width: 42,
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
