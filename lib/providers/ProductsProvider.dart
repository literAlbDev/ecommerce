import 'dart:convert';
import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider extends ChangeNotifier {
  late int id;
  Map<String, dynamic>? products;
  Map<String, dynamic>? product;
  Map<String, dynamic> categorizedProducts = {};
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

  void categorize(List categories) {
    startLoading();
    copy();
    if (categories.length == 0) {
      endLoading();
      return;
    }
    List elements = [];
    categorizedProducts["data"].forEach((element) {
      if (!categories.contains(element["attributes"]["category"]["id"])) {
        elements.add(element);
      }
    });
    elements.forEach((element) {
      categorizedProducts["data"].remove(element);
    });
    //categorizedProducts = {};
    endLoading();
  }

  void copy() {
    categorizedProducts = jsonDecode(jsonEncode(products));
  }

  Future<bool> initProducts() async {
    startLoading(notify: false);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().products(sharedPreferences.getString("token")!);
    if (result.keys.last != "errors") {
      products = result;
      copy();
      endLoading();
      return true;
    }

    endLoading();
    return false;
  }

  Future<bool> getProducts() async {
    startLoading();

    bool rc = await initProducts();

    endLoading();
    return rc;
  }

  void setProduct(int id){
    this.id = id;
  }

  Future<bool> initProduct() async {
    startLoading(notify: false);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().product(sharedPreferences.getString("token")!, id);
    if (result.keys.last != "errors") {
      product = result;
      endLoading();
      return true;
    }

    endLoading();
    return false;

  }

  Future<bool> getProduct() async {
    startLoading();

    bool rc = await initProduct();

    endLoading();
    return rc;
  }

}
