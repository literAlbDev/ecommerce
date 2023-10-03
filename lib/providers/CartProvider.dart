import 'dart:convert';

import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List cart = [];
  double total = 0.0;

  Map<String, dynamic> result = {};
  String errors = '';
  bool loading = false;

  void calculateTotal(){
    total = 0.0;
    cart.forEach((element) {
      total += double.parse(element["data"]["attributes"]["price"]) * element["quantity"];
    });
    notifyListeners();
    saveToLocal();
  }

  Future loadFromLocal() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("cart") == null)
      cart = [];
    else
      cart = jsonDecode(sharedPreferences.getString("cart")!);
    calculateTotal();
  }

  Future saveToLocal() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("cart", jsonEncode(cart));
  }

  bool inCart(Map product) {
    return cart
        .firstWhere(
          (element) => element['data']['id'] == product['data']['id'],
          orElse: () => {},
        )
        .isNotEmpty;
  }

  void setQuantity(Map product, int quantity) {
    cart.firstWhere((element) =>
            element['data']['id'] == product['data']['id'])['quantity'] =
        quantity <= product['data']['attributes']['stock']
            ? quantity > 0
                ? quantity
                : 1
            : product['data']['attributes']['stock'];
    calculateTotal();
  }

  void addToCart(Map product) {
    cart.add(product);
    setQuantity(product, 1);
    calculateTotal();
  }

  void removeFromCart(Map product) {
    int i = cart.indexWhere(
        (element) => element['data']['id'] == product['data']['id']);
    cart.removeAt(i);
    calculateTotal();
  }

  void clearCart() {
    cart.clear();
    calculateTotal();
  }

  void startLoading({bool notify = true}) {
    errors = '';
    loading = true;
    notify ? notifyListeners() : null;
  }

  void endLoading({bool notify = true}) {
    loading = false;
    notify ? notifyListeners() : null;
  }

  Future<bool> order() async {
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().order(sharedPreferences.getString("token")!, cart);
    print(result);
    if (result.keys.last != "errors") {
      clearCart();
      endLoading();
      return true;
    }

    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }
}
