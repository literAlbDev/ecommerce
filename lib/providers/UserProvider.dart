import 'package:ecommerce/common/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? user;
  Map<String, dynamic> result = {};
  String errors = '';
  bool loading = false;
  bool isVisible = false;

  void toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void startLoading() {
    errors = '';
    loading = true;
    notifyListeners();
  }

  void endLoading() {
    loading = false;
    notifyListeners();
  }

  Future<bool> getMe() async {
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().me(sharedPreferences.getString("token")!);
    print(result);
    if (result.keys.last != "errors") {
      user = result;
      endLoading();
      return true;
    }

    endLoading();
    return false;
  }

  Future<bool> login(String email, String password) async {
    startLoading();

    result = await Api().login(email, password);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (result.keys.last != "errors") {
      sharedPreferences.setString("token", result['token']);
      return getMe();
    }
    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> signup(
      String name, String email, String password, String rpassword) async {
    startLoading();

    if (password != rpassword) {
      errors = "the passwords does not match";
      endLoading();
      return false;
    }

    result = await Api().signup(name, email, password);
    if (result.keys.last != "errors") {
      return login(email, password);
    }
    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> logout() async {
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().logout(sharedPreferences.getString("token")!);
    if (result.keys.last != "errors") {
      sharedPreferences.remove("token");
      endLoading();
      return true;
    }
    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> updateMe(
      String name, String email, String password, String rpassword) async {
    startLoading();

    if (password != rpassword) {
      errors = "the passwords does not match";
      endLoading();
      return false;
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api()
        .updateMe(sharedPreferences.getString("token")!, name, email, password);
    if (result.keys.last != "errors") {
      return getMe();
    }

    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> addAddress(
    String firstName,
    String lastName,
    String addressLine1,
    String addressLine2,
    String country,
    String state,
    String city,
    String zipCode,
  ) async {
    startLoading();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().addAddress(
      sharedPreferences.getString("token")!,
      firstName,
      lastName,
      addressLine1,
      addressLine2,
      country,
      state,
      city,
      zipCode,
    );
    if (result.keys.last != "errors") {
      return getMe();
    }
    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> updateAddress(
    String firstName,
    String lastName,
    String addressLine1,
    String addressLine2,
    String country,
    String state,
    String city,
    String zipCode,
    int id,
  ) async {
    startLoading();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = await Api().updateAddress(
      sharedPreferences.getString("token")!,
      firstName,
      lastName,
      addressLine1,
      addressLine2,
      country,
      state,
      city,
      zipCode,
      id,
    );
    if (result.keys.last != "errors") {
      return getMe();
    }
    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }

  Future<bool> deleteAddress(int id) async {
    startLoading();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result =
        await Api().deleteAddress(sharedPreferences.getString("token")!, id);
    if (result.keys.last != "errors") {
      return getMe();
    }
    result['errors'].forEach((key, value) {
      errors += value[0] + "\n";
    });
    endLoading();
    return false;
  }
}
