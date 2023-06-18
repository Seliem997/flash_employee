import 'package:flash_employee/ui/inventory/screens/widgets/transaction_item.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/attributeOptionModel.dart';
import '../../../providers/transactions_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/enum/date_formats.dart';
import '../../../utils/font_styles.dart';
import '../../sidebar_drawer/sidebar_drawer.dart';
import '../../widgets/attribute_selector.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/spaces.dart';

class TransactionsHistoryScreen extends StatefulWidget {
  const TransactionsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsHistoryScreen> createState() =>
      _TransactionsHistoryScreenState();
}

class _TransactionsHistoryScreenState extends State<TransactionsHistoryScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    Future.delayed(Duration(seconds: 0)).then((value) => loadData());
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
    super.initState();
  }

  void loadData({bool clearSearch = false}) async {
    final TransactionsProvider transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    if (!clearSearch) {
      transactionsProvider.resetTransactionsScreen();
    }
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
      body: Padding(
          padding: symmetricEdgeInsets(vertical: 15, horizontal: 24),
          child: Column(children: [
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
                transactionsProvider.searchTransactions(value!);
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
                          title: "Type",
                          choices: AttributeOption.transactionTypes,
                          previouslySelectedChoice:
                              transactionsProvider.selectedTransactionType,
                          onValueChanged: (value) {
                            transactionsProvider.selectedTransactionType =
                                value;
                          },
                        );
                      },
                    );
                  },
                  labelText:
                      transactionsProvider.selectedTransactionType?.title ??
                          'Type',
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
                                    transactionsProvider.selectedDate ??
                                        DateTime.now(),
                                firstDate: DateTime.utc(DateTime.now().year),
                                lastDate:
                                    DateTime.now().add(Duration(days: 180)))
                            .then((value) {
                          if (value != null) {
                            transactionsProvider.selectedDate = value;
                          }
                        });
                      },
                      labelText: transactionsProvider.selectedDate != null
                          ? DateFormat(DFormat.dmyDecorated.key)
                              .format(transactionsProvider.selectedDate!)
                          : 'Today',
                      textColor: AppColor.filterGrey,
                      backgroundButton: const Color(0xFFF0F0F0),
                      borderColor: AppColor.filterGrey,
                      border: true,
                    ),
                    horizontalSpace(5),
                    Visibility(
                      visible: transactionsProvider.selectedDate != null,
                      child: CustomContainer(
                          onTap: () {
                            transactionsProvider.selectedDate = null;
                          },
                          radiusCircular: 5,
                          height: 40,
                          borderColor: Colors.red[200],
                          padding: EdgeInsets.all(3),
                          backgroundColor: AppColor.borderGray,
                          child:
                              Icon(Icons.close, color: Colors.red, size: 17)),
                    )
                  ],
                ),
              ],
            ),
            verticalSpace(15),
            transactionsProvider.loadingTransactions
                ? DataLoader()
                : transactionsProvider.transactions!.isEmpty
                    ? NoDataPlaceHolder(useExpand: false)
                    : Expanded(
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
