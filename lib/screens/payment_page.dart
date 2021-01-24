import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userorders.dart';
import '../providers/admin.dart';

class Payment extends StatefulWidget {
  final routeName = "payment";
  final imageUrl;
  final title;
  final price;
  Payment({this.imageUrl, this.title, this.price});
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  UserOrders a;
  IsAdmin c;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (a == null) {
      a = Provider.of<UserOrders>(context, listen: false);
      c = Provider.of<IsAdmin>(context, listen: false);
    }
    super.didChangeDependencies();
  }

  var _count = 1;
  void _increment() {
    setState(() {
      _count++;
    });
    // _count++;
  }

  void _decrement() {
    setState(() {
      if (_count != 1) {
        _count--;
      }
    });
  }

  Future<void> showAlertBox(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Order conformed"),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  "ok",
                  style: TextStyle(color: Colors.yellow[900], fontSize: 20),
                ),
              )
            ],
          );
        });
  }

  void addOrder(int count, String productImageUrl, double productPrice,
      String productTittle) async {
    final b = UserOrder(
        count: count,
        productImageUrl: productImageUrl,
        productPrice: productPrice,
        productTitle: productTittle);
    a.addOrdere(b, c.userId);
    await showAlertBox(context);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        title: Text(
          'Food Order',
          style: TextStyle(
              color: Colors.yellow[800],
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 40),
                  width: MediaQuery.of(context).size.width * (1 / 3),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.fill)),
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width * (1 / 3),
                      child: Center(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: _increment),
                          Text(
                            _count.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                              onPressed: _decrement)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(20),
            child: Text(
              "Total Amount is \$ ${(_count * widget.price).toStringAsFixed(3)}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: ListTile(
                onTap: () => addOrder(
                    _count, widget.imageUrl, widget.price, widget.title),
                subtitle: Text("Pay here"),
                leading: Image.asset(
                  "lib/assets/images/debitcardimage.jpeg",
                  fit: BoxFit.fill,
                ),
                title: Text(
                  "Debit Card",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: ListTile(
                onTap: () => addOrder(
                    _count, widget.imageUrl, widget.price, widget.title),
                subtitle: Text("Pay here"),
                leading: Image.asset(
                  "lib/assets/images/creditcard.jpg",
                  fit: BoxFit.fill,
                ),
                title: Text(
                  "Credit Card",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: ListTile(
                onTap: () => addOrder(
                    _count, widget.imageUrl, widget.price, widget.title),
                subtitle: Text("Pay here"),
                leading: Image.asset(
                  "lib/assets/images/gpay.png",
                  fit: BoxFit.fill,
                ),
                title: Text(
                  "Gpay",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: ListTile(
                onTap: () => addOrder(
                    _count, widget.imageUrl, widget.price, widget.title),
                subtitle: Text("Pay here"),
                leading: Image.asset(
                  "lib/assets/images/phonepay.png",
                  fit: BoxFit.fill,
                ),
                title: Text(
                  "phonepe",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
