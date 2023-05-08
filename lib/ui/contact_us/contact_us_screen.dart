import 'package:flash_employee/models/contactusModel.dart';
import 'package:flash_employee/providers/contact_us_provider.dart';
import 'package:flash_employee/services/common_service.dart';
import 'package:flash_employee/ui/duty/duty_screen.dart';
import 'package:flash_employee/ui/widgets/custom_form_field.dart';
import 'package:flash_employee/ui/widgets/navigate.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/snack_bars.dart';
import '../sidebar_drawer/sidebar_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/data_loader.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    // mainEventBus.on<InvoiceAddedEvent>().listen((event) {
    //   loadData();
    // });
    super.initState();
  }

  void loadData() async {
    final ContactUsProvider contactUsProvider =
        Provider.of<ContactUsProvider>(context, listen: false);
    await contactUsProvider.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    final ContactUsProvider contactUsProvider =
        Provider.of<ContactUsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Contact Us",
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
              padding: symmetricEdgeInsets(horizontal: 25, vertical: 10),
              child: contactUsProvider.loadingContacts
                  ? const DataLoader()
                  : contactUsProvider.contacts!.isEmpty
                      ? const NoDataPlaceHolder(useExpand: false)
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: contactUsProvider.contacts!.length,
                          itemBuilder: (context, index) {
                            return ContactItem(
                                contact: contactUsProvider.contacts![index]);
                          },
                          separatorBuilder: (context, index) =>
                              verticalSpace(10),
                        )),
        ],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);
  final ContactData contact;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 55,
      padding: symmetricEdgeInsets(horizontal: 20, vertical: 20),
      radiusCircular: 6,
      backgroundColor: const Color(0xffE0E0E0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: TextWidget(
              text: "${contact.username}",
              textSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          DefaultButton(
            text: "Duty",
            padding: EdgeInsets.zero,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            height: 25,
            width: 58,
            onPressed: () {
              navigateTo(context, DutyScreen(duties: contact.duties));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomContainer(
                onTap: () {
                  CommonService.callNumber(contact.phone!, context);
                },
                height: 25,
                width: 25,
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                image: const DecorationImage(
                    image: AssetImage("assets/images/telephone.png"),
                    fit: BoxFit.fitHeight),
              ),
              horizontalSpace(10),
              CustomContainer(
                onTap: () {
                  CommonService.openWhatsapp(contact.phone!, context);
                },
                height: 25,
                width: 25,
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                image: const DecorationImage(
                    image: AssetImage("assets/images/whatsapp.png"),
                    fit: BoxFit.fitHeight),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
