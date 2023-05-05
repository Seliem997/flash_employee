import 'package:flash_employee/ui/inventory/screens/widgets/transaction_item.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/transactions_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import '../../sidebar_drawer/sidebar_drawer.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/spaces.dart';

class TransactionsHistoryScreen extends StatefulWidget {
  const TransactionsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsHistoryScreen> createState() =>
      _TransactionsHistoryScreenState();
}

class _TransactionsHistoryScreenState extends State<TransactionsHistoryScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
    super.initState();
  }

  void loadData() async {
    final TransactionsProvider transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    await transactionsProvider.loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();

    final TransactionsProvider transactionsProvider =
        Provider.of<TransactionsProvider>(context);
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: const TextWidget(
          text: "Transactions",
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        leading: BackButton(),
        centerTitle: true,
      ),
      body: transactionsProvider.loadingTransactions
          ? DataLoader()
          : transactionsProvider.transactions!.isEmpty
              ? NoDataPlaceHolder(useExpand: false)
              : Padding(
                  padding: symmetricEdgeInsets(vertical: 15, horizontal: 24),
                  child: Column(children: [
                    DefaultFormField(
                      hintText: 'Transaction ID Search',
                      hintStyle: TextStyle(
                        fontWeight: MyFontWeight.medium,
                        fontSize: MyFontSize.size12,
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
                          labelText: 'Transaction type',
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
                      itemCount: transactionsProvider.transactions!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => verticalSpace(24),
                      itemBuilder: (context, index) {
                        return TransactionItem(
                            transactionsProvider.transactions![index]);
                      },
                    )),
                    // verticalSpace(110)
                  ])),
      // drawer: const SidebarDrawer(), //Drawer
    );
  }
}
