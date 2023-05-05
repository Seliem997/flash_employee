import 'package:flash_employee/events/events/invoice_added_event.dart';
import 'package:flash_employee/events/global_event_bus.dart';
import 'package:flash_employee/ui/invoices/widgets/new_invoice_screen.dart';
import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/invoices_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
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
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    mainEventBus.on<InvoiceAddedEvent>().listen((event) {
      loadData();
    });
    super.initState();
  }

  void loadData() async {
    final InvoicesProvider invoicesProvider =
        Provider.of<InvoicesProvider>(context, listen: false);
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextWidget(
                                              text: 'Request ID : ',
                                              textSize: 14,
                                              fontWeight: MyFontWeight.semiBold,
                                            ),
                                            TextWidget(
                                              text: invoicesProvider
                                                  .invoices![index].id
                                                  .toString(),
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
                                              text: 'Type : ',
                                              textSize: 14,
                                              fontWeight: MyFontWeight.semiBold,
                                            ),
                                            TextWidget(
                                              text: invoicesProvider
                                                  .invoices![index]
                                                  .invoiceType!
                                                  .name
                                                  .toString(),
                                              textSize: 14,
                                              fontWeight: MyFontWeight.medium,
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
                                              fontWeight: MyFontWeight.medium,
                                              color: AppColor.grey,
                                            ),
                                          ],
                                        ),
                                        verticalSpace(10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 12,
                                              color: Color(0xff616161),
                                            ),
                                            horizontalSpace(15),
                                            TextWidget(
                                              text: invoicesProvider
                                                  .invoices![index].date
                                                  .toString(),
                                              textSize: 14,
                                              fontWeight: MyFontWeight.medium,
                                              color: AppColor.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/Export Pdf.png',
                                        height: 42,
                                        width: 42,
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
                      verticalSpace(15),
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
                      verticalSpace(125)
                    ],
                  ),
                ),
                invoicesProvider.invoices!.isEmpty
                    ? NoDataPlaceHolder(useExpand: false)
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomContainer(
                          // width: double.infinity,
                          // height: 140,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(32),
                              topLeft: Radius.circular(32)),
                          backgroundColor: Color(0xffC7E4F8),
                          padding:
                              symmetricEdgeInsets(horizontal: 20, vertical: 4),
                          borderColor: AppColor.primary,
                          // alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    invoicesProvider.invoicesTypes!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: 40),
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            '${invoicesProvider.invoicesTypes![index].name!} : ',
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
                              verticalSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomContainer(
                                    height: 22,
                                    width: 22,
                                    padding: EdgeInsets.zero,
                                    radiusCircular: 0,
                                    backgroundColor: Colors.transparent,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/share.png"),
                                        fit: BoxFit.fitHeight),
                                  ),
                                  Row(
                                    children: [
                                      Row(
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
