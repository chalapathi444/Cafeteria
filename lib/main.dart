import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/adminorders.dart';
import './screens/add_product_form.dart';
import './screens/overview_of_food.dart';
import './screens/overiew_of_food2.dart';
import './providers/products.dart';
import './screens/admin_home_screen.dart';
import './screens/login_form.dart';
import 'package:http/http.dart' as https;
import './screens/admin_login.dart';
import './screens/user_login.dart';
import './providers/admin.dart';
import './screens/user_home_screen.dart';
import './providers/userorders.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => IsAdmin()),
        ChangeNotifierProvider(create: (ctx) => UserOrders()),
        ChangeNotifierProvider(create: (ctx) => Adminorders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Welcome.routeName,
        routes: {
          AdimHomeScreen.routeName: (ctx) => AdimHomeScreen(),
          OverviewProductAdmin.routeName: (ctx) => OverviewProductAdmin(),
          OverviewProductUser.routeName: (ctx) => OverviewProductUser(),
          ProductForm.routeName: (ctx) => ProductForm(),
          Welcome.routeName: (ctx) => Welcome(),
          AdminLogin.routeName: (ctx) => AdminLogin(),
          UserLogin.routeName: (ctx) => UserLogin(),
          UserHomeScreen.routeName: (ctx) => UserHomeScreen(),
        },
      ),
    );
  }
}
