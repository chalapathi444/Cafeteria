import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//product descibes data about the single food item in cafteria.
class Product {
  final String imageUrl;
  final double price;
  final bool isNonVeg;
  final String description;
  final int delevaryTime;
  final String title;
  Product(
      {this.imageUrl,
      this.price,
      this.isNonVeg,
      this.delevaryTime,
      this.title,
      this.description});
}

class Products extends ChangeNotifier {
  void reset() {
    fetched = false;
    _items = [];
  }

  bool fetched = false;
  List<Product> _items = [
    /*  Product(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/cafeteriaapp-d5c73.appspot.com/o/images%2Fimage_picker1953259552549681001.jpg%7D'?alt=media&token=e0ee6e38-4ad1-42f4-a515-68fe0edf033c",
        price: 20.0,
        isNonVeg: false,
        title: 'chapathi',
        delevaryTime: 30,
        description:
            'It is a common staple in the Indian subcontinent as well as amongst expatriates from the Indian subcontinent throughout the world. Chapatis were also introduced to other parts of the world by immigrants from the Indian subcontinent, particularly by Indian merchants to Central Asia, Southeast Asia, East Africa, and the'),
    Product(
        imageUrl:
            'https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco/k%2FPhoto%2FRecipes%2F2020-07-how-to-make-a-milkshake-at-home%2F2020-06-08_AT-K19388',
        price: 323.9,
        isNonVeg: false,
        delevaryTime: 30,
        title: 'milk shake',
        description:
            "A milkshake, or simply shake, is a drink that is traditionally made by blending cow's milk, ice cream, and flavorings or sweeteners such as butterscotch, caramel sauce, chocolate syrup, fruit syrup, or whole fruit into a thick, sweet, cold mixture."),
    Product(
        imageUrl:
            'https://i.pinimg.com/originals/11/e0/40/11e0400ae1d6c0cbc4756ef16d20db66.jpg',
        price: 32.3,
        isNonVeg: false,
        title: 'Meals',
        delevaryTime: 30,
        description:
            'Delicious meals are tasty, appetizing, scrumptious, yummy, luscious, delectable, mouth-watering, fit for a king, delightful, lovely, wonderful, pleasant, enjoyable, appealing, enchanting, charming.'),*/
  ];
  void fechAndDecode() async {
    if (fetched) return;
    var url = "https://back-code.herokuapp.com/showItems";
    Map<String, String> customHeaders = {"content-type": "application/json"};
    var responce = await http.get(url, headers: customHeaders);
    List<dynamic> lis = json.decode(responce.body);
    for (int i = 0; i < lis.length; i++) {
      print(lis[i]);
      _items.add(Product(
          title: lis[i]["item_name"],
          delevaryTime: int.parse(lis[i]["delivery_time"].toString()),
          description: lis[i]['description'],
          imageUrl: lis[i]["image_url"],
          isNonVeg: lis[i]["category"] == 1 ? true : false,
          price: double.parse(lis[i]["price"].toString())));
    }
    print("the lenght is ");
    print(_items.length);
    fetched = true;
    //notifyListeners();
  }

  void addProducts(Product p) async {
    print("product aded\n\nyeah");
    // print(p.imageUrl);
    //  if (p.imageUrl is String) print("this is the string");
    var url = "https://back-code.herokuapp.com/add";
    //var aa = 0;
    Map<String, dynamic> data = {
      "name": p.title,
      "price": p.price,
      "time": p.delevaryTime,
      "description": p.description,
      "category": p.isNonVeg,
      "imgUrl": p.imageUrl,
    };
    Map<String, String> customHeaders = {"content-type": "application/json"};

    /// var body = jsonEncode(data);
    var response =
        await http.post(url, headers: customHeaders, body: jsonEncode(data));
    print(jsonDecode(response.body));
    print("entering here");
    _items.add(p);

    notifyListeners();
  }

  List<Product> items() {
    var l = [..._items];
    //print(l.length);
    return l;
  }

  int length() {
    // print('length is ${_items.length}');
    return _items.length;
  }
}
