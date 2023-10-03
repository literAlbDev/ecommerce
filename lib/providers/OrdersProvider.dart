import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersProvider extends ChangeNotifier {
  late int id;
  Map<String, dynamic> orders = {};
  Map<String, dynamic> order = {};
  Map<String, dynamic> result = {};
  String errors = '';
  bool loading = true;

  void startLoading({bool notify = true}) {
    errors = '';
    loading = true;
    notify ? notifyListeners() : null;
  }

  void endLoading({bool notify = true}) {
    loading = false;
    notify ? notifyListeners() : null;
  }

  Future<bool> initOrders() async {
    startLoading(notify: false);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().orders(sharedPreferences.getString("token")!);
    if (result.keys.last != "errors") {
      orders = result;
      endLoading();
      return true;
    }

    endLoading();
    return false;
  }

  Future<bool> getOrders() async {
    startLoading();

    bool rc = await initOrders();

    endLoading();
    return rc;
  }

  void setOrder(int id){
    this.id = id;
  }
}
