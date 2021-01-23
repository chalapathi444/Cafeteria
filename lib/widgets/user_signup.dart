import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/products.dart";
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart';
import "dart:io";
import "package:path/path.dart" as Path;
import '../providers/admin.dart';
import '../screens/user_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class UserSingupForm extends StatefulWidget {
  static const routeName = '/ProductForm';
  Function c;
  UserSingupForm(this.c);
  @override
  _UserSingupFormState createState() => _UserSingupFormState();
}

class _UserSingupFormState extends State<UserSingupForm> {
  GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  File _image;
  var loading = false;
  var _isloading = false;
  final picker = ImagePicker();
  IsAdmin obj;
  void didChangeDependencies() {
    if (obj == null) {
      obj = Provider.of<IsAdmin>(context, listen: false);
    }
    super.didChangeDependencies();
  }

  Map<String, dynamic> prime = {
    "fullName": "s",
    "organizationName": 2,
    "employeeId": true,
    "mobileNumber": 30,
    "e-mail": "chapaathi",
    "imageUrl": "nothing happen",
    "password": "",
  };
  Future<String> ShowAlertBox(BuildContext context) async {
    bool ok = false;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            actions: [
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.yellow[900]),
                ),
                onPressed: () {
                  ok = false;
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.yellow[900]),
                ),
                onPressed: () {
                  ok = true;
                  Navigator.of(ctx).pop();
                },
              )
            ],
            title: Text("preivew"),
            content: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(prime["imageUrl"]))),
                  ),
                  Text(
                    "Name: ${prime["fullName"]}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Emplooye Id: ${prime["employeeId"]}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Organization Name : ${prime["organizationName"]}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Mobile Number : ${prime["mobileNumber"]}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "E -Mail : ${prime["e-mail"]}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        });
    print("value of ok is ${ok}");
    if (ok == false) {
      return "cancel";
    }
    return "ok";
  }

  void save() async {
    // print(_myKey.currentState.validate());
    if (_myKey.currentState.validate() != true) {
      return null;
    }
    //  print(prime[''])
    print(prime);
    obj.chagne_to_user();
    final url = "https://back-code.herokuapp.com/signup";
    Map<String, String> customHeaders = {
      "content-type": "application/json",
    };
    var data = {
      "emp_name": prime["fullName"],
      "empid": prime["employeeId"],
      "org_name": prime["organizationName"],
      "email": prime["employeeId"],
      "mobile": int.parse(prime["mobileNumber"]),
      "password": prime["password"],
      "id_card": prime["imageUrl"],
    };
    String aa = await ShowAlertBox(context);
    if (aa == "cancel") return;
    print(aa);
    var body = json.encode(data);
    setState(() {
      _isloading = true;
    });
    var response = await http.post(url, headers: customHeaders, body: body);
    print(response);
    setState(() {
      _isloading = false;
    });
    //Navigator.of(context).pop();
    widget.c();
  }

  Future<void> getImage() async {
    setState(() {
      loading = true;
    });
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("images/${Path.basename(_image.path)}}'");
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    //setState(() {});
    await uploadTask.onComplete;
    var imageUrl = await storageReference.getDownloadURL();
    prime["imageUrl"] = imageUrl;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.yellow[800],
          ))
        : Form(
            key: _myKey,
            child: ListView(
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "Full Name",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
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
                      prime["fullName"] = value;
                      //print(prime);
                      if (value.isEmpty) return "please enter valid text";
                      //if(value.contains())
                      return null;
                    },
                    style: TextStyle(fontSize: 16),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.name,
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "Organization Name",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
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
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: 16),
                    cursorColor: Colors.black,
                    validator: (value) {
                      prime["organizationName"] = value;
                      if (value.isEmpty) return "please enter valid text";
                      return null;
                    },
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "EmployeeId",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
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
                      // bool isValid = EmailValidator.validate(value);
                      prime["employeeId"] = value;
                      //if (value.isEmpty) return "Enter valid email";
                      if (value.isEmpty) {
                        return "Please enter valid id";
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "Mobile Number",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    // maxLines: 4,
                    validator: (value) {
                      prime["mobileNumber"] = value;
                      if (value.isEmpty) return "please enter valid text";
                      return null;
                    },
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
                    "E-mail Id",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
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
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    // maxLines: 4,
                    validator: (value) {
                      if (!EmailValidator.validate(value))
                        return "Enter valid email";
                      prime["e-mail"] = value;
                      if (value.isEmpty) return "please enter valid text";
                      return null;
                    },
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
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
                      prime["password"] = value;
                      if (value.isEmpty) return "please enter valid text";
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
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
                    "ID card",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
                  ),
                ),
                _image == null
                    ? Center(
                        child: Container(
                            height: 200,
                            width: 200,
                            color: Colors.yellow[100],
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo),
                              onPressed: getImage,
                            )),
                      )
                    : Center(
                        child: Container(
                            height: 200,
                            width: 200,
                            child: Image.file(
                              _image,
                              fit: BoxFit.fill,
                            )),
                      ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: save,
                  child: loading
                      ? Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 3,
                              right: MediaQuery.of(context).size.width / 3),
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 3,
                              right: MediaQuery.of(context).size.width / 3),
                          color: Colors.yellow[900],
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                )
              ],
            ),
          );
  }
}
