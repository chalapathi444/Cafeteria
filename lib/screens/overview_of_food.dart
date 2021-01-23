import 'package:flutter/material.dart';
import '../providers/products.dart' show Product;

class OverviewProductAdmin extends StatelessWidget {
  static const routeName = '/productoverview';
  Product food;
  @override
  Widget build(BuildContext context) {
    food = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              height: 40,
              margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.yellow[500],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(7)),
              child: IconButton(
                icon: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: null,
              ))
        ],
        leading: Container(
          height: 20,
          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          width: 20,
          padding: EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(7)),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.black,
            ),
            //iconSize: 8,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            //height: 150,
            padding: EdgeInsets.only(left: 10),
            width: 240,
            //color: Colors.green,
            color: Colors.yellow[100],
            child: Text(
              food.title,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$",
                  style: TextStyle(color: Colors.yellow[900]),
                ),
                SizedBox(width: 5),
                Text(
                  food.price.toString(),
                  style: TextStyle(color: Colors.yellow[900], fontSize: 40),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2 - 10,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      "Delivery time",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${food.delevaryTime} Minutes",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Veg or Non-Veg",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      food.isNonVeg ? "Non-Veg" : "Veg",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          food.imageUrl,
                        ),
                        fit: BoxFit.fill)),
                height: 250,
                width: MediaQuery.of(context).size.width / 2 - 20,
              )
            ],
          ),
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "About",
                style: TextStyle(fontSize: 30, color: Colors.yellow[900]),
              ),
            ),
          ),
          Container(
            child: Text(
              food.description,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      )),
    );
  }
}
