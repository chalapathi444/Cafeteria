import 'dart:math';

import 'package:flutter/material.dart';
import './admin_login.dart';
import './user_login.dart';

class Welcome extends StatelessWidget {
  static const routeName = "/welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'lib/assets/images/homepage.jpg',
                    ),
                    fit: BoxFit.fill)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 6,
                left: 10,
                right: 10,
                bottom: 30),
            child: Column(
              children: [
                Container(
                  child: Text(
                    "CAFETERIA",
                    style: TextStyle(
                        color: Colors.white, fontSize: 40, letterSpacing: 10),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  // color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LayoutBuilder(
                          builder: (ctx, constraints) => InkWell(
                                onTap: () => Navigator.pushNamed(
                                    ctx, UserLogin.routeName),
                                child: Container(
                                  //color: Colors.green,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  height: constraints.maxHeight / 2 - 10,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: Center(
                                    child: Text(
                                      "User",
                                      style: TextStyle(
                                          color: Colors.yellow[900],
                                          fontSize: 30),
                                    ),
                                  ),
                                ),
                              )),
                      LayoutBuilder(
                          builder: (ctx, constraints) => InkWell(
                                onTap: () => Navigator.pushNamed(
                                    ctx, AdminLogin.routeName),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  //color: Colors.green,
                                  height: constraints.maxHeight / 2 - 10,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: Center(
                                    child: Text(
                                      "Admin",
                                      style: TextStyle(
                                          color: Colors.yellow[900],
                                          fontSize: 30),
                                    ),
                                  ),
                                ),
                              )),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Container()
        ],
      ),
    );
  }
}
