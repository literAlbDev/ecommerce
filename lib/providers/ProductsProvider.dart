import 'dart:convert';
import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  late int id;
  Map<String, dynamic>? products;
  Map<String, dynamic> categorizedProducts = {};
  Map<String, dynamic> result = {};
  String errors = '';
  bool loading = true;

  void startLoading() {
    errors = '';
    loading = true;
    notifyListeners();
  }

  void endLoading() {
    loading = false;
    notifyListeners();
  }

  void categorize(List categories) {
    //print("$categories" + " " + categories.length.toString());
    startLoading();
    copy();
    //print(products);
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
      print(categorizedProducts["data"].indexOf(element) );
      categorizedProducts["data"].remove(element);
    });
    //categorizedProducts = {};
    endLoading();
  }

  void copy() {
    categorizedProducts = jsonDecode(jsonEncode(products));
  }

  Future<bool> getProducts() async {
    startLoading();

    result = await Api().products();
    if (result.keys.last != "errors") {
      products = result;
      copy();
      endLoading();
      return true;
    }

    endLoading();
    return false;
  }
}
