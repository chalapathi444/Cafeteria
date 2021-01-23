import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Adminorder {
  final String imageUrl;
  final String empId;
  final String itemName;
  final double price;
  final int count;
  Adminorder(
      {this.imageUrl, this.empId, this.itemName, this.price, this.count});
}

class Adminorders extends ChangeNotifier {
  List<Adminorder> _orders = [];
  get orders {
    return [..._orders].reversed.toList();
  }

  void change() {
    notifyListeners();
  }

  void reset() {
    _orders = [];
  }

  void fetchAndDecode() async {
    final String url = "https://back-code.herokuapp.com/orders/showOrders";
    final response = await http.get(url);
    final responceData = json.decode(response.body);
    print("ther response is ");
    print(responceData);
    List<Adminorder> temp = [];
    for (int i = 0; i < responceData.length; i++) {
      temp.add(Adminorder(
          imageUrl: responceData[i]["imgUrl"],
          count: responceData[i]["count"],
          empId: responceData[i]["emp_id"],
          itemName: responceData[i]["item_name"],
          price: double.parse(responceData[i]["price"].toString())));
    }
    _orders = temp;
    //  notifyListeners();
  }
}
