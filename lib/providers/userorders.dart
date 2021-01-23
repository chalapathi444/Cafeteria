import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserOrder {
  final productImageUrl;
  final productTitle;
  final count;
  final productPrice;
  UserOrder(
      {this.productImageUrl, this.productPrice, this.productTitle, this.count});
}

class UserOrders extends ChangeNotifier {
  void reset() {
    _orders = [];
    fetched = false;
  }

  List<UserOrder> _orders = [];
  bool fetched = false;
  get getorders {
    return [..._orders].reversed.toList();
  }

  Future<void> fetchData(String userId) async {
    if (!fetched) {
      final url = "https://back-code.herokuapp.com/orders/ordersForUser";
      print("fetched");
      Map<String, String> customHeader = {"content-type": "application/json"};
      final response = await http.post(url,
          headers: customHeader, body: jsonEncode({"user_id": userId}));
      var temp = [];
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      for (int i = 0; i < data.length; i++) {
        temp.add(UserOrder(
            productImageUrl: data[i]["imgUrl"],
            productPrice: double.parse(data[i]["price"].toString()),
            productTitle: data[i]["item_name"],
            count: data[i]["count"]));
      }
      _orders = [...temp];
      // notifyListeners();
    }
    print(_orders.length);
    fetched = true;
  }

  void addOrdere(UserOrder b, String userId) async {
    var url = "https://back-code.herokuapp.com/orders/userOrders";
    var data = {
      "user_id": userId,
      "imgUrl": b.productImageUrl,
      "item_name": b.productTitle,
      "price": b.productPrice,
      "count": b.count
    };
    final Map<String, String> customHeader = {
      "content-type": "application/json"
    };
    await http.post(url, body: jsonEncode(data), headers: customHeader);
    _orders.add(b);
    notifyListeners();
  }
}
