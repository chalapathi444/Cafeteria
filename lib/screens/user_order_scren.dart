import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin.dart';
import '../providers/userorders.dart';

class UserOrdersScreen extends StatefulWidget {
  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  List<UserOrder> orders = [];
  bool _isloading = false;
  bool called = true;
  @override
  void call() async {
    print("calling");
    // TODO: implement didChangeDependencies
    if (orders.isEmpty) {
      print("coming here");
      setState(() {
        _isloading = true;
      });
      UserOrders obj = Provider.of<UserOrders>(context, listen: true);
      final String ad = Provider.of<IsAdmin>(context, listen: false).userId;
      await obj.fetchData(ad);
      setState(() {
        print("it is falsing");
        _isloading = false;
      });
      orders = obj.getorders;
    }
    // super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //  didChangeDependencies();
    if (called) {
      call();
      called = false;
    }
    print("entering");
    return _isloading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ),
          )
        : orders.length == 0
            ? Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * (5 / 9),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('lib/assets/images/noordersuser.png'),
                    )),
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "No orders Yet",
                      style: TextStyle(fontSize: 20, color: Colors.yellow[700]),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(orders[index].productImageUrl),
                            radius: 40,
                          ),
                          title: Text(
                            orders[index].productTitle,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                              "Total amout is ${orders[index].count * orders[index].productPrice}"),
                          trailing: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Icon(
                                Icons.fastfood,
                                size: 40,
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.pink[900]),
                                child: Center(
                                    child: Text(
                                  "${orders[index].count}",
                                  style: TextStyle(color: Colors.white),
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
  }
}
