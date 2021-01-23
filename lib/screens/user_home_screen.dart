import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/providers/products.dart';
import 'package:sample_project/providers/userorders.dart';
import '../screens/add_product.dart';
import './products_screen.dart';
import './user_order_scren.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/User';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  var _selectedIndex = 0;
  void navigateToSomething(index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget MyWidget(var index) {
    if (index == 0) {
      return ProductScreen();
    }
    if (index == 1) {
      return UserOrdersScreen();
    }
  }

  Future<bool> showAlterBox() async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(ctx, false);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.yellow[900]),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).reset();
                  Provider.of<UserOrders>(context, listen: false).reset();
                  Navigator.pop(ctx, true);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.yellow[900]),
                ),
              )
            ],
            content: Text(
              "Do you want to exit",
            ),
          );
        });
  }

  Future<bool> call() async {
    return showAlterBox();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: call,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          /* leading: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80"),
                    fit: BoxFit.fill)),
          ),*/
          centerTitle: true,
          title: Text(
            'Apple Cafeteria',
            style: TextStyle(
                color: Colors.yellow[800],
                fontSize: 30,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          //   Colors.black,
          elevation: 0,
        ),
        body: MyWidget(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.fastfood,
                  color: Colors.black,
                ),
                label: 'Food Items'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt,
                  color: Colors.black,
                ),
                label: "My Orders"),
          ],
          onTap: (index) => navigateToSomething(index),
          selectedItemColor: Colors.amber[800],
        ),
      ),
    );
  }
}
