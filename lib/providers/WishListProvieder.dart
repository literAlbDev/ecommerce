import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListProvider extends ChangeNotifier {
  late int id;
  Map<String, dynamic>? wishlist;
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

  Future<bool> initWishList() async{
    startLoading(notify: false);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().wishlist(sharedPreferences.getString("token")!);
    if (result.keys.last != "errors") {
      wishlist = result;
      endLoading();
      return true;
    }

    endLoading();
    return false;
  }

  Future<bool> getWishList() async{
    startLoading();

    bool rc = await initWishList();

    endLoading();
    return rc;
  }

  Future<bool> addWishList(int id) async{
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().addWishlist(sharedPreferences.getString("token")!, id);
    print("WISHLIST ADD:" + result.toString());
    if (result.keys.last != "errors") {
      return getWishList();
    }

    endLoading();
    return false;
  }

  Future<bool> removeWishList(int id) async{
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().removeWishlist(sharedPreferences.getString("token")!, id);
    print("WISHLIST REMOVE:" + result.toString());
    if (result.keys.last != "errors") {
      return getWishList();
    }

    endLoading();
    return false;
  }

}
