import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  late int id;
  Map<String, dynamic>? categories;
  List selectedCategories = [];
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

  void selectCategory(int id){
    startLoading();
    if(!isSelected(id)) {
      selectedCategories.add(id);
    }
    endLoading();
  }

  void deselectCategory(int id){
    startLoading();
    if(isSelected(id)) {
      selectedCategories.remove(id);
    }
    endLoading();
  }

  bool isSelected(int id){
    return selectedCategories.contains(id);
  }

  Future<bool> initCategories() async{
    startLoading(notify: false);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().categories(sharedPreferences.getString("token")!);
    if (result.keys.last != "errors") {
      categories = result;

      endLoading();
      return true;
    }
    endLoading();
    return false;
  }

  Future<bool> getCategories() async{
    startLoading();

    bool rc = await initCategories();

    endLoading();
    return rc;
  }

}
