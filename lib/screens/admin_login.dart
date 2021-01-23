import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin.dart';
import './admin_home_screen.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/admin_login';

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool _isLoading = false;
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  IsAdmin a;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (a == null) {
      a = Provider.of<IsAdmin>(context, listen: false);
    }
    super.didChangeDependencies();
  }

  Future<void> popUp(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    "ok",
                    style: TextStyle(color: Colors.yellow, fontSize: 17),
                  ))
            ],
            content: Text(
              "Incorrect credientials",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  var loginCreditials = {"userId": "", "password": ""};
  void save(var context) {
    _formState.currentState.validate();
    _formState.currentState.save();
    print(loginCreditials);
    a.change_to_admin();
    if (loginCreditials["userId"] == "apple_cafeteria" &&
        loginCreditials["password"] == "Apple@123") {
      Navigator.pushReplacementNamed(
        context,
        AdimHomeScreen.routeName,
      );
    } else {
      popUp(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cafeteria',
          style: TextStyle(
              color: Colors.yellow[800],
              fontSize: 30,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        //   Colors.black,,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.yellow[100],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Admin login",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
                Center(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: MediaQuery.of(context).size.height * (3 / 7),
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      color: Colors.white,
                      child: Form(
                        key: _formState,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                "User Name",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 17),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              height: 50,
                              //  color: Colors.yellow[100],
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blueGrey)),
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  // print(value);
                                  //print(prime["title"]);
                                  //print(enabled);
                                  // prime["title"] = value;
                                  loginCreditials["userId"] = value;
                                  print(value);
                                  //print(prime);
                                  if (value.isEmpty)
                                    return "please enter valid text";
                                  //if(value.contains())
                                  return null;
                                },
                                style: TextStyle(fontSize: 16),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    // hintText: "chapathi",
                                    //labelText: "Food name",
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    fillColor: Colors.yellow,
                                    contentPadding: EdgeInsets.all(4)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                "password",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 17),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              height: 50,
                              //  color: Colors.yellow[100],
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blueGrey)),
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  // print(value);
                                  //print(prime["title"]);
                                  //print(enabled);
                                  // prime["title"] = value;
                                  //print(prime);
                                  print(value);
                                  loginCreditials["password"] = value;
                                  if (value.isEmpty)
                                    return "please enter valid text";
                                  //if(value.contains())
                                  return null;
                                },
                                style: TextStyle(fontSize: 16),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    // hintText: "chapathi",
                                    //labelText: "Food name",
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    fillColor: Colors.yellow,
                                    contentPadding: EdgeInsets.all(4)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => save(context),
                              child: Container(
                                height: 40,
                                width: 30,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 5,
                                    right:
                                        MediaQuery.of(context).size.width / 5),
                                color: Colors.yellow[900],
                                child: Center(
                                  child: Text(
                                    "LOG IN",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
