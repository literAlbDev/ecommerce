import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  late int id;
  Map<String, dynamic>? categories;
  List selectedCategories = [];
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

  Future<bool> getCategories() async{
    startLoading();

    result = await Api().categories();
    if (result.keys.last != "errors") {
      categories = result;
      categories?["data"].forEach((element) {
        selectedCategories.add(element["id"]);
      });
      endLoading();
      return true;
    }

    endLoading();
    return false;
  }

}
