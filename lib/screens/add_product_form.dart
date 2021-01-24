import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/products.dart";
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart';
import "dart:io";
import "package:path/path.dart" as Path;

class ProductForm extends StatefulWidget {
  static const routeName = '/ProductForm';
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  Products products;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (products == null) {
      products = Provider.of<Products>(context, listen: false);
    }
    super.didChangeDependencies();
  }

  var enabled = false;
  File _image;
  var loading = false;
  final picker = ImagePicker();

  Map<String, dynamic> prime = {
    "imageUrl": "s",
    "price": 2,
    "isNonVeg": true,
    "delevaryTime": 30,
    "title": "chapaathi",
    "description": "nothing happen",
  };
  void save() {
    _myKey.currentState.validate();
    //  print(prime[''])
    final Product p = Product(
        delevaryTime: int.parse(prime["delevaryTime"]),
        title: prime['title'],
        price: prime['price'],
        imageUrl: prime['imageUrl'].toString(),
        description: prime["description"],
        isNonVeg: prime['isNonVeg']);
    products.addProducts(p);
    Navigator.of(context).pop();
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
    print(imageUrl);
    prime["imageUrl"] = imageUrl;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          margin: EdgeInsets.all(10),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              //color: Colors.black,
              border: Border.all(color: Colors.black)),
          child: Container(
              padding: EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )),
        ),
      ),
      body: Form(
        key: _myKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Food Item",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Name",
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
                  prime["title"] = value;
                  //print(prime);
                  if (value.isEmpty) return "please enter valid text";
                  //if(value.contains())
                  return null;
                },
                style: TextStyle(fontSize: 16),
                cursorColor: Colors.black,
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
                "Price",
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
                style: TextStyle(fontSize: 16),
                cursorColor: Colors.black,
                validator: (value) {
                  prime["price"] = double.parse(value);
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
                "Delivary Time",
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
                  prime["delevaryTime"] = value;
                  if (value.isEmpty) return "please enter valid text";
                  return null;
                },
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
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
                "About",
                style: TextStyle(color: Colors.grey[600], fontSize: 17),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              height: 70,
              //  color: Colors.yellow[100],
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueGrey)),
              width: double.infinity,
              child: TextFormField(
                cursorColor: Colors.black,
                maxLines: 4,
                validator: (value) {
                  prime["description"] = value;
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
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text("Is NonVeg"),
                ),
                Switch(
                  value: enabled,
                  activeColor: Colors.yellow[900],
                  activeTrackColor: Colors.yellow[900],
                  onChanged: (value) => setState(() {
                    prime["isNonVeg"] = value;
                    enabled = value;
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Item Image",
                style: TextStyle(color: Colors.grey[600], fontSize: 17),
              ),
            ),
            SizedBox(
              height: 20,
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
                          "ADD",
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                          "ADD",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
