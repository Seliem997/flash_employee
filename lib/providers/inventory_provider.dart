import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/inventoryModel.dart';
import '../services/inventory_service.dart';

class InventoryProvider extends ChangeNotifier {
  final InventoryService inventoryService = InventoryService();
  List<InventoryItemData>? inventoryItems;
  bool loadingInventoryItems = true;

  Future getInventoryItems() async {
    loadingInventoryItems = true;
    notifyListeners();
    await inventoryService.getInventoryItems().then((value) {
      loadingInventoryItems = false;
      if (value.status == Status.success) {
        inventoryItems = value.data as List<InventoryItemData>?;
      }
    });
    notifyListeners();
  }
}
