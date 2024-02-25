import 'dart:developer';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flash_employee/main.dart';
import 'package:flash_employee/models/attributeOptionModel.dart';
import 'package:flash_employee/ui/home/widgets/request_item.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/data_loader.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/no_data_place_holder.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../events/events/request_updated_event.dart';
import '../../events/global_event_bus.dart';
import '../../generated/l10n.dart';
import '../../providers/requests_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/colors.dart';
import '../../utils/enum/date_formats.dart';
import '../../utils/font_styles.dart';
import '../notifications/notifications_screen.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/attribute_selector.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  void initState() {
    searchController = TextEditingController();
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    mainEventBus.on<RequestUpdatedEvent>().listen((event) {
      loadData();
    });
    super.initState();
  }

  void loadData({bool clearSearch = false}) async {
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context, listen: false);
    await _handleLocationPermission();
    await _getCurrentLocation();
    if (!clearSearch) {
      requestsProvider.resetRequestsScreen();
    }
    await requestsProvider.getRequests();
  }


  _getCurrentLocation() async {
    final RequestsProvider requestsProvider =
    Provider.of<RequestsProvider>(context, listen: false);
    try {
      AppLoader.showLoader(context);
      await Geolocator.getCurrentPosition().then((Position position) async {
        AppLoader.stopLoader();
        requestsProvider.currentPosition = position;
        requestsProvider.mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.5,
            ),
          ),
        );
      }).catchError((e) {
        log("Error in accessing current location $e");
      });
    } catch (e) {
      log("Error in accessing current location $e");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('location Services Are Disabled Please Enable The Services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('location Permissions Are Denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('location Permissions Are Permanently Denied We Cannot Request Permissions')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);
    final RequestsProvider requestsProvider =
        Provider.of<RequestsProvider>(context);
    log("Rebuild");

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
                const Spacer(),
                InkWell(
                  child: ExpandTapWidget(
                      onTap: () {
                        navigateTo(context, const NotificationsScreen());
                      },
                      tapPadding: const EdgeInsets.all(30.0),
                      child: const Icon(Icons.notifications_none, size: 20)),
                )
              ],
            ),
            verticalSpace(24),
            DefaultFormField(
              controller: searchController,
              hintText: 'Search for request by Request ID / Customer Name',
              hintStyle: TextStyle(
                fontWeight: MyFontWeight.medium,
                fontSize: MyFontSize.size12,
                color: const Color(0xFF949494),
              ),
              onSubmit: (value) {
                requestsProvider.searchRequests(value!);
              },
              filled: true,
              fillColor: AppColor.babyBlue,
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
                          title: "Status Type",
                          choices: AttributeOption.statusOptions,
                          previouslySelectedChoice:
                              requestsProvider.selectedStatusType,
                          onValueChanged: (value) {
                            requestsProvider.selectedStatusType = value;
                          },
                        );
                      },
                    );
                  },
                  labelText: requestsProvider.selectedStatusType?.title ??
                      'Status type',
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
                                initialDate: requestsProvider.selectedDate ??
                                    DateTime.now(),
                                firstDate: DateTime.utc(DateTime.now().year),
                                lastDate:
                                    DateTime.now().add(const Duration(days: 180)))
                            .then((value) {
                          if (value != null) {
                            requestsProvider.selectedDate = value;
                          }
                        });
                      },
                      labelText: requestsProvider.selectedDate != null
                          ? DateFormat(DFormat.dmyDecorated.key)
                              .format(requestsProvider.selectedDate!)
                          : 'Today',
                      textColor: AppColor.filterGrey,
                      backgroundButton: const Color(0xFFF0F0F0),
                      borderColor: AppColor.filterGrey,
                      border: true,
                    ),
                    horizontalSpace(5),
                    Visibility(
                      visible: requestsProvider.selectedDate != null,
                      child: CustomContainer(
                          onTap: () {
                            requestsProvider.selectedDate = null;
                          },
                          radiusCircular: 5,
                          height: 40,
                          borderColor: Colors.red[200],
                          padding: const EdgeInsets.all(3),
                          backgroundColor: AppColor.borderGray,
                          child:
                              const Icon(Icons.close, color: Colors.red, size: 17)),
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
                      requestsProvider.loadingRequests
                          ? const DataLoader()
                          : requestsProvider.requests!.isEmpty
                              ? const NoDataPlaceHolder(useExpand: false)
                              : ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
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
