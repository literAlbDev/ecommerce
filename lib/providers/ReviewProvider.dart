import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewProvider extends ChangeNotifier {
  Map<String, dynamic> result = {};
  Map review = {};
  int rate = 1;
  String errors = '';
  bool loading = false;

  void startLoading({bool notify = true}) {
    errors = '';
    loading = true;
    notify ? notifyListeners() : null;
  }

  void endLoading({bool notify = true}) {
    loading = false;
    notify ? notifyListeners() : null;
  }

  void setRate(int _rate){
    rate = _rate;
    notifyListeners();
  }

  void setReview(Map rev){
    review = rev;
    notifyListeners();
  }

  void set(Map rev, int _rate){
    setRate(_rate);
    setReview(rev);
  }

  Future<bool> addReview(int productId, String review) async {
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().addReview(sharedPreferences.getString("token")!, productId, review, rate);
    if (result.keys.last != "errors") {
      endLoading();
      return true;
    }

    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> updateReview(int id, String review) async {
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().updateReview(sharedPreferences.getString("token")!, id, review, rate);
    print(result);
    if (result.keys.last != "errors") {
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
