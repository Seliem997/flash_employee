import 'package:flash_employee/services/contact_us_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/contactusModel.dart';

class ContactUsProvider extends ChangeNotifier {
  final ContactUsService contactUsService = ContactUsService();
  List<ContactData>? contacts;
  bool loadingContacts = true;

  Future getContacts() async {
    loadingContacts = true;
    notifyListeners();
    await contactUsService.getContacts().then((value) {
      loadingContacts = false;
      if (value.status == Status.success) {
        contacts = value.data as List<ContactData>?;
      }
    });
    notifyListeners();
  }
}
