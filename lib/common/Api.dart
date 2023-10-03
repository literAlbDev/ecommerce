import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  late Map<String, dynamic> result;
  Map<String, dynamic> errorMessage = {
    "message": "error",
    "errors": {
      "error": ["check your interent and try again"]
    }
  };

  int statusCode = 0;
  String baseUrl = "http://192.168.1.2:8000/api/v1";

  Future<dynamic> login(String email, String password) async {
    var url = Uri.parse(baseUrl + "/user/login");
    String request = jsonEncode({
      "email": email,
      "password": password,
      "device_name": "flutter_app",
    });

    http.Response response;
    try {
      response = await http.post(
        url,
        headers: headers,
        body: request,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> signup(String name, String email, String password) async {
    var url = Uri.parse(baseUrl + "/user/signup");
    String request = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    http.Response response;
    try {
      response = await http.post(
        url,
        headers: headers,
        body: request,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> logout(String token) async {
    var url = Uri.parse(baseUrl + "/user/logout");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    http.Response response;
    try {
      response = await http.delete(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> me(String token) async {
    var url = Uri.parse(baseUrl + "/user/me");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    http.Response response;
    try {
      response = await http.get(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }
    return result;
  }

  Future<dynamic> updateMe(
      String token, String name, String email, String password) async {
    var url = Uri.parse(baseUrl + "/user/update");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    String request = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    http.Response response;
    try {
      response = await http.put(
        url,
        headers: headersWithToken,
        body: request,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> addAddress(
    String token,
    String firstName,
    String lastName,
    String addressLine1,
    String addressLine2,
    String country,
    String state,
    String city,
    String zipCode,
  ) async {
    var url = Uri.parse(baseUrl + "/addresses");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });
    String request = jsonEncode({
      "first_name": firstName,
      "last_name": lastName,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "country": country,
      "state": state,
      "city": city,
      "zip_code": zipCode,
    });

    http.Response response;
    try {
      response = await http.post(
        url,
        headers: headersWithToken,
        body: request,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> updateAddress(
    String token,
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
    var url = Uri.parse(baseUrl + "/addresses/$id");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    String request = jsonEncode({
      "first_name": firstName,
      "last_name": lastName,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "country": country,
      "state": state,
      "city": city,
      "zip_code": zipCode,
    });

    http.Response response;
    try {
      response = await http.put(
        url,
        headers: headersWithToken,
        body: request,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> deleteAddress(String token, int id) async {
    var url = Uri.parse(baseUrl + "/addresses/$id");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    http.Response response;
    try {
      response = await http.delete(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> products(String token) async {
    var url = Uri.parse(baseUrl + "/products");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });


    http.Response response;
    try {
      response = await http.get(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> product(String token, int id) async {
    var url = Uri.parse(baseUrl + "/products/$id");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });


    http.Response response;
    try {
      response = await http.get(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> categories(String token) async {
    var url = Uri.parse(baseUrl + "/categories");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });


    http.Response response;
    try {
      response = await http.get(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> wishlist(String token) async {
    var url = Uri.parse(baseUrl + "/whishlist");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    http.Response response;
    try {
      response = await http.get(
        url,
        headers: headersWithToken,
      );
      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> addWishlist(String token, id) async {
    var url = Uri.parse(baseUrl + "/whishlist");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    String request = jsonEncode({"product_id": id});

    http.Response response;
    try {
      response = await http.post(
        url,
        headers: headersWithToken,
        body: request,
      );

      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> removeWishlist(String token, id) async {
    var url = Uri.parse(baseUrl + "/whishlist/$id");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    http.Response response;
    try {
      response = await http.delete(
        url,
        headers: headersWithToken,
      );

      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> order(String token, List products) async {
    var url = Uri.parse(baseUrl + "/orders");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    String request = jsonEncode({"products": products});

    http.Response response;
    try {
      response = await http.post(
        url,
        headers: headersWithToken,
        body: request,
      );

      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }

  Future<dynamic> orders(String token) async {
    var url = Uri.parse(baseUrl + "/orders");
    Map<String, String> headersWithToken = headers;
    headersWithToken.addAll({
      'Authorization': "Bearer $token",
    });

    http.Response response;
    try {
      response = await http.get(
        url,
        headers: headersWithToken,
      );

      statusCode = response.statusCode;

      result = jsonDecode(response.body);
    } on Exception {
      result = errorMessage;
    }

    return result;
  }
}
