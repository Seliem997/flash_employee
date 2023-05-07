import 'package:flash_employee/main.dart';
import 'package:flash_employee/ui/home/widgets/request_item.dart';
import 'package:flash_employee/ui/request_details/request_details_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/requests_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
    super.initState();
  }

  void loadData() async {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context, listen: false);
    await requestsProvider.getRequests();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      key: globalKey,
      body: Padding(
        padding: onlyEdgeInsets(top: 68, start: 24, end: 24),
        child: Column(
          children: [
            Row(
              children: [
                CustomSizedBox(
                  width: 24,
                  height: 24,
                  onTap: () {
                    globalKey.currentState!.openDrawer();
                  },
                  child: SvgPicture.asset(
                    'assets/svg/menu.svg',
                    color:
                        MyApp.themeMode(context) ? Colors.white : Colors.black,
                  ),
                ),
                horizontalSpace(12),
                TextWidget(
                  text: 'Hi, ${userDataProvider.userName}',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size14,
                  color: const Color(0xFF292D32),
                ),
              ],
            ),
            verticalSpace(24),
            DefaultFormField(
              hintText:
                  'Search for request by Request ID / Customer ID / Mobile',
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
                  labelText: 'Status type',
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
                      requestsProvider.loadingRequests
                          ? const DataLoader()
                          : requestsProvider.requests!.isEmpty
                              ? const NoDataPlaceHolder(useExpand: false)
                              : ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: symmetricEdgeInsets(vertical: 10),
                                  shrinkWrap: true,
                                  itemCount: requestsProvider.requests!.length,
                                  itemBuilder: (context, index) {
                                    return RequestItem(
                                        request:
                                            requestsProvider.requests![index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      verticalSpace(15)),
                    ],
                  )),
            )
          ],
        ),
      ),
      drawer: const SidebarDrawer(), //Drawer
    );
  }
}
